package main

import (
	"log"
	"net/http"

	di "github.com/charlieroth/lab/go/learn-go-with-tests/dependency-injection"
)

func myGreetHandler(w http.ResponseWriter, r *http.Request) {
	di.Greet(w, "world")
}

func main() {
	log.Fatal(http.ListenAndServe(":8080", http.HandlerFunc(myGreetHandler)))
}