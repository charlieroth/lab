package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type Message struct {
	Name string `json:"name"`
	Body string `json:"body"`
	Time int64  `json:"time"`
}

func main() {
	m := Message{Name: "Alice", Body: "Hello", Time: 1294706395881547000}
	fmt.Println("m:", m)

	// Encode a struct value to []byte
	b, err := json.Marshal(m)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("b: %s\n", b)

	// Decode []byte to a struct value
	var m2 Message
	err = json.Unmarshal(b, &m2)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("m2:", m2)

	// Decode arbitrary JSON into a generic data container
	b2 := []byte(`{"Name":"Charlie","Age":28,"Location":"Gothenburg"}`)
	var p interface{}
	err = json.Unmarshal(b2, &p)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("p(%T): %v\n", p, p)
}
