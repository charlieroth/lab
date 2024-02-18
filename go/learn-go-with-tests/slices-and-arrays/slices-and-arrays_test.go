package slicesandarrays

import (
	"reflect"
	"testing"
)

func TestSum(t *testing.T) {
	t.Run("returns 15 given the slice []{1,2,3,4,5}", func(t *testing.T) {
		numbers := []int{1, 2, 3, 4, 5}
		actual := Sum(numbers)
		expected := 15

		if actual != expected {
			t.Errorf("expected: %d\nactual: %d", expected, actual)
		}
	})
}

func TestSumAll(t *testing.T) {
	t.Run("returns []{15, 14} given the slices [][]int{[]int{1,2,3,4,5}, []int{2,3,4,5}}", func(t *testing.T) {
		actual := SumAll([]int{1, 2, 3, 4, 5}, []int{2, 3, 4, 5})
		expected := []int{15, 14}

		if !reflect.DeepEqual(actual, expected) {
			t.Errorf("expected: %d\nactual: %d", expected, actual)
		}
	})
}
