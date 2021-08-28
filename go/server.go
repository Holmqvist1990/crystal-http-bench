package main

import (
	"fmt"
	"net/http"
	"sync"

	jsoniter "github.com/json-iterator/go"
)

var (
	port   = 3000
	people = People{}
	json   = jsoniter.ConfigCompatibleWithStandardLibrary
)

func main() {
	http.HandleFunc("/", router)
	if err := http.ListenAndServe(fmt.Sprintf(":%v", port), nil); err != nil {
		panic(err)
	}
}

func router(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "GET":
		people.mu.Lock()
		defer people.mu.Unlock()
		json, err := json.Marshal(people.v)
		if err != nil {
			w.WriteHeader(500)
			return
		}
		w.Write(json)
		break
	case "POST":
		var p Person
		err := json.NewDecoder(r.Body).Decode(&p)
		if err != nil {
			return
		}
		people.mu.Lock()
		defer people.mu.Unlock()
		people.v = append(people.v, p)
		w.WriteHeader(201)
		break
	}
}

type Person struct {
	Name       string      `json:"name"`
	Email      string      `json:"email"`
	Residences []Residence `json:"residences"`
}

type Residence struct {
	Street  string `json:"street"`
	City    string `json:"city"`
	Country string `json:"country"`
}

type People struct {
	v  []Person
	mu sync.Mutex
}
