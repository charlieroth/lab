package main

import (
	"log"
	"math/rand"
	"time"
)

type JobResult[T any] struct {
	Result T
}

type Job[T any] interface {
	Run() (JobResult[T], error)
}

type Adder struct {
	Num1 int
	Num2 int
}

func (a Adder) Run() (JobResult[int], error) {
	randSeconds := rand.Intn(3)
	randSleep := time.Duration(randSeconds) * time.Second
	time.Sleep(randSleep)
	return JobResult[int]{Result: a.Num1 + a.Num2}, nil
}

func Work(id int, jobs <-chan Job[int], results chan<- JobResult[int]) {
	for job := range jobs {
		result, _ := job.Run()
		results <- result
	}
}

func main() {
	numJobs := rand.Intn(10) + 1
	jobs := make(chan Job[int], numJobs)
	results := make(chan JobResult[int], numJobs)

	for w := 1; w <= numJobs; w++ {
		go Work(w, jobs, results)
	}

	for j := 1; j <= numJobs; j++ {
		jobs <- Adder{Num1: rand.Intn(100), Num2: rand.Intn(100)}
	}
	close(jobs)

	for a := 1; a <= numJobs; a++ {
		result := <-results
		log.Printf("Result: %d", result.Result)
	}
}
