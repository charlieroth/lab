package mocking

import (
	"bytes"
	"reflect"
	"testing"
)

const sleep = "sleep"
const write = "write"

type SpyCountdownOperations struct {
	Calls []string
}

func (s *SpyCountdownOperations) Sleep() {
	s.Calls = append(s.Calls, sleep)
}

func (s *SpyCountdownOperations) Write(p []byte) (n int, err error) {
	s.Calls = append(s.Calls, write)
	return
}

func TestCountdown(t *testing.T) {
	t.Run("prints 3 to Go!", func (t *testing.T) {
		buffer := &bytes.Buffer{}	
		Countdown(buffer, &SpyCountdownOperations{})
		
		actual := buffer.String()
		expected := "3\n2\n1\nGo!"

		if actual != expected {
			t.Errorf("expected: %s\nactual: %s", expected, actual)
		}
	})

	t.Run("sleep before every print", func (t *testing.T) {
		buffer := &bytes.Buffer{}
		spySleepPrinter := &SpyCountdownOperations{}
		Countdown(spySleepPrinter, spySleepPrinter)
		
		actual := buffer.String()
		expected := []string{
			write,
			sleep,
			write,
			sleep,
			write,
			sleep,
			write,
		}

		if !reflect.DeepEqual(expected, spySleepPrinter.Calls) {
			t.Errorf("expected: %s\nactual: %s", expected, actual)
		}
	})
}