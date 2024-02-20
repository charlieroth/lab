package synchronization

import (
	"sync"
	"testing"
)

func assertCounter(t testing.TB, actual *Counter, expected int) {
	t.Helper()
	if actual.Value() != expected {
		t.Errorf("actual: %d\nexpected %d", actual.Value(), expected)
	}
}

func TestCounter(t *testing.T) {
	t.Run("incrementing the counter 3 times leaves it at 3", func(t *testing.T) {
		counter := NewCounter()
		counter.Inc()
		counter.Inc()
		counter.Inc()
		assertCounter(t, counter, 3)
	})

	t.Run("it runs safely concurrently", func(t *testing.T) {
		counter := NewCounter()
		expected := 1000

		var wg sync.WaitGroup
		wg.Add(expected)
		for range expected {
			go func() {
				counter.Inc()
				wg.Done()
			}()
		}
		wg.Wait()
		assertCounter(t, counter, expected)
	})
}