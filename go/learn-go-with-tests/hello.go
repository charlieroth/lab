package main

import "fmt"

func Hello(name, language string) (string, error) {
	prefixes := map[string]string{
		"English": "Hello",
		"Spanish": "Hola",
		"French":  "Bonjour",
	}

	if name == "" && language == "" {
		return "Hello, world", nil
	}

	if name != "" && language == "" {
		return fmt.Sprintf("Hello, %s", name), nil
	}

	prefix, ok := prefixes[language]
	if !ok {
		return "", fmt.Errorf("unsupported language: %s", language)
	}

	return fmt.Sprintf("%s, %s", prefix, name), nil
}

func main() {
	fmt.Println(Hello("Charlie", "English"))
}
