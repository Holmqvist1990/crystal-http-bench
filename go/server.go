package main

import (
	"fmt"
	"net/http"
	"github.com/json-iterator/go"
)

var (
	port   = 3000
	people = []Person{}
	json = jsoniter.ConfigCompatibleWithStandardLibrary
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
		json, err := json.Marshal(people)
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
		people = append(people, p)
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
