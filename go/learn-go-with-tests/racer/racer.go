package racer

import (
	"fmt"
	"net/http"
	"time"
)

func ping(url string) chan struct{} {
	// `chan struct{}`` is the smallest data type available from a memory
	// perspective so we get no allocation versus a bool
	c := make(chan struct{})
	go func() {
		http.DefaultClient.Get(url)
		close(c)
	}()
	return c
}

func WebsiteRacer(a, b string, timeout time.Duration) (string, error) {
	select {
	case <-time.After(timeout):
		return "", fmt.Errorf("failed to ping urls in less than 10 seconds")
	case <-ping(a):
		return a, nil
	case <-ping(b):
		return b, nil
	}
}
