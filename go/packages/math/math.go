package math

func Average(nums []float64) float64 {
	sum := float64(0)
	for _, num := range nums {
		sum += num
	}

	return sum / float64(len(nums))
}
