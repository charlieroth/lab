package main

import (
	"fmt"

	env "github.com/charlieroth/lab/go/go-http/env"
	"github.com/gofiber/fiber/v2"
)

func main() {
	env, err := env.New(".env.json")
	if err != nil {
		panic(err)
	}

	app := fiber.New()

	app.Get("/ping", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{"msg": "pong"})
	})

	app.Post("/echo", func(c *fiber.Ctx) error {
		type EchoRequestBody struct {
			Msg string `json:"msg"`
		}

		body := new(EchoRequestBody)
		if err := c.BodyParser(body); err != nil {
			return c.Status(400).JSON(fiber.Map{"error": "failed to parse request body"})
		}

		return c.Status(200).JSON(fiber.Map{"message": body.Msg})
	})

	app.Listen(fmt.Sprintf(":%d", env.Port))
}
