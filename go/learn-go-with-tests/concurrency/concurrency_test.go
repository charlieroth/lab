package concurrency

import (
	"reflect"
	"testing"
	"time"
)

func mockWebsiteChecker(url string) bool {
	return url != "https://meta.com"
}

func slowStubWebsiteChecker(url string) bool {
	time.Sleep(20 * time.Millisecond)
	return true
}

func TestCheckWebsites(t *testing.T) {
	t.Run("", func(t *testing.T) {
		urls := []string{
			"https://google.com",
			"https://x.com",
			"https://news.ycombinator.com",
			"https://meta.com",
		}

		expected := map[string]bool{
			"https://google.com": true,
			"https://x.com": true,
			"https://news.ycombinator.com": true,
			"https://meta.com": false,
		}

		actual := CheckWebsites(mockWebsiteChecker, urls)

		if !reflect.DeepEqual(actual, expected) {
			t.Fatalf("expected: %v\nactual: %v", expected, actual)
		}
	})
}

func BenchmarkCheckWebsite(b *testing.B) {
	urls := make([]string, 100)
	
	for i := 0; i < len(urls); i++ {
		urls[i] = "a url"
	}
	b.ResetTimer()
	
	for i := 0; i < b.N; i++ {
		CheckWebsites(slowStubWebsiteChecker, urls)
	}
}