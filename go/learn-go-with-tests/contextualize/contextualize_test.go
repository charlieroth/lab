package contextualize

import (
	"context"
	"errors"
	"log"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

type SpyStore struct {
	response string
	cancelled bool
	t *testing.T
}

func (store *SpyStore) Fetch(ctx context.Context) (string, error) {
	data := make(chan string, 1)
	
	// We are simulating a slow process where we build the result
	// slowly by appending the string, character by character in
	// a goroutine
	go func() {
		var result string
		for _, c := range store.response {
			select {
			case <-ctx.Done():
				log.Println("spy store got cancelled")
				return
			default:
				time.Sleep(10 * time.Millisecond)
				result += string(c)
			}
		}
		data <- result
	}()

	select {
	case <-ctx.Done():
		return "", ctx.Err()
	case res := <-data:
		return res, nil
	}
}

type SpyResponseWriter struct {
	written bool
}

func (w *SpyResponseWriter) Header() http.Header {
	w.written = true
	return nil
}

func (w *SpyResponseWriter) Write([]byte) (int, error) {
	w.written = true
	return 0, errors.New("not implemented")
}

func (w *SpyResponseWriter) WriteHeader(statusCode int) {
	w.written = true
}

func TestServer(t *testing.T) {
	t.Run("returns data from store", func(t *testing.T) {
		expected := "hello, world"
		store := &SpyStore{response: expected, cancelled: false, t: t}
		server := Server(store)
		
		request := httptest.NewRequest(http.MethodGet, "/", nil)
		response := httptest.NewRecorder()
		
		server.ServeHTTP(response, request)
		actual := response.Body.String()
		
		if actual != expected {
			t.Errorf("expected: %s\nactual %s", actual, expected)
		}
	})

	t.Run("tells store to cancel work if request is cancelled", func(t *testing.T) {
		expected := "hello, world"
		store := &SpyStore{response: expected, t: t}
		server := Server(store)

		request := httptest.NewRequest(http.MethodGet, "/", nil)
		cancellingCtx, cancel := context.WithCancel(request.Context())
		time.AfterFunc(5*time.Millisecond, cancel)
		request = request.WithContext(cancellingCtx)
		
		response := &SpyResponseWriter{}
		server.ServeHTTP(response, request)
		
		if response.written {
			t.Error("a response should not have been written")
		}
	})
}