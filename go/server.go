package main

import (
	"encoding/json"
	"log"
	"net/http"
	"sync"

	"github.com/gofiber/fiber/v2"
)

func main() {
	people := People{
		v:  []Person{},
		mu: sync.RWMutex{},
	}
	app := fiber.New(fiber.Config{
		JSONEncoder: json.Marshal,
		JSONDecoder: json.Unmarshal,
	})
	app.Get("/", func(c *fiber.Ctx) error {
		people.mu.RLock()
		defer people.mu.RUnlock()
		return c.JSON(people.v)
	})
	app.Post("/", func(c *fiber.Ctx) error {
		var p Person
		if err := c.BodyParser(&p); err != nil {
			return err
		}
		go func() {
			people.mu.Lock()
			defer people.mu.Unlock()
			people.v = append(people.v, p)
		}()
		return c.SendStatus(http.StatusCreated)
	})
	log.Fatal(app.Listen(":3000"))
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
	mu sync.RWMutex
}
