package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

func GitStatus(location string) {
    err := os.Chdir(location)
    if err != nil {
        log.Fatal(err)
    }

    out, err := exec.Command("git", "status").Output()
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(string(out))
}

func main() {
    GitStatus("/Users/charlie/github.com/charlieroth/me")
}
