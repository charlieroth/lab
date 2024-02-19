package racer

import (
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

func makeDelayedServer(delay time.Duration) *httptest.Server {
	return httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		time.Sleep(delay)
		w.WriteHeader(http.StatusOK)
	}))
}

func TestWebsiteRacer(t *testing.T) {
	t.Run("compares speeds of servers, returning the url of the fastest one", func(t *testing.T) {
		slowServer := makeDelayedServer(20 * time.Millisecond)
		fastServer := makeDelayedServer(0 * time.Millisecond)
		defer slowServer.Close()
		defer fastServer.Close()
		slowURL := slowServer.URL
		fastURL := fastServer.URL

		expected := fastURL
		actual, err := WebsiteRacer(slowURL, fastURL, 10*time.Second)
		if err != nil {
			t.Errorf(err.Error())
			return
		}

		if expected != actual {
			t.Errorf("expected: %s\nactual: %s", expected, actual)
		}
	})

	t.Run("returns an error if a server doesn't respond within 10s", func(t *testing.T) {
		slowServer := makeDelayedServer(11 * time.Second)
		fastServer := makeDelayedServer(12 * time.Second)
		defer slowServer.Close()
		defer fastServer.Close()

		slowURL := slowServer.URL
		fastURL := fastServer.URL

		_, err := WebsiteRacer(slowURL, fastURL, 10*time.Second)
		if err == nil {
			t.Errorf("expected error didn't get one")
		}
	})
}
