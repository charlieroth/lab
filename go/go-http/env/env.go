package env

import (
	"encoding/json"
	"errors"
	"io/ioutil"
	"os"
)

type Env struct {
	Port int `json:"port"`
}

func New(path string) (*Env, error) {
	// load json file into string
	envFile, err := os.Open(path)
	if err != nil {
		return nil, errors.New("failed to load env")
	}
	defer envFile.Close()
	// read file into []byte
	bytes, _ := ioutil.ReadAll(envFile)
	// unmarshal []byte into Env struct
  env := Env{}
	err = json.Unmarshal(bytes, &env)
  if err != nil {
		return nil, errors.New("failed to load env")
	}

	return &env, nil
}
