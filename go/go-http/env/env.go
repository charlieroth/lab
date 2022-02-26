package env

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strings"
)

func Set(key string, value string) error {
  return os.Setenv(key, value)
}

func Get(key string) string {
  return os.Getenv(key)
}

func Load(path string) error {
	// load json file into string
	envFile, err := os.Open(path)
	if err != nil {
		return errors.New("failed to load env")
	}
	defer envFile.Close()

  // set environment variables
	scanner := bufio.NewScanner(envFile)
	for scanner.Scan() {
		line := scanner.Text()
		if line == "\n" {
			continue
		}
		if !strings.Contains(line, "=") {
			continue
		}


		envVar := strings.Split(line, "=")
    fmt.Printf("%s=%s\n", envVar[0], envVar[1])
    os.Setenv(envVar[0], envVar[1])
	}

  return nil
}
