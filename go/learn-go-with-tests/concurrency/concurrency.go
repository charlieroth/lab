package concurrency

type WebsiteChecker func(string) bool
type result struct {
	url string
	success bool
}

func CheckWebsites(wc WebsiteChecker, urls []string) map[string]bool {
	results := make(map[string]bool)
	resultChannel := make(chan result)
	for _, url := range urls {
		go func(u string) {
			// Send statement
			resultChannel <- result{u, wc(u)}
		}(url)
	}
	
	for range len(urls) {
		// Receive statement
		r := <-resultChannel
		results[r.url] = r.success
	}
	
	return results
}