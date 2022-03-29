package main

import (
	"context"
	"fmt"
	"log"
	"os"

	env "github.com/charlieroth/lab/go/go-http/env"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/jackc/pgx/v4"
)

type Person struct {
	Name string
	Age  int
}

func DatabaseURL() string {
	return fmt.Sprintf(
		"postgresql://%s:%s@%s:%s/%s",
		os.Getenv("POSTGRES_USER"),
		os.Getenv("POSTGRES_PASSWORD"),
		os.Getenv("POSTGRES_HOST"),
		os.Getenv("POSTGRES_PORT"),
		os.Getenv("POSTGRES_DB"),
	)
}

func main() {
	err := env.Load(".env")
	if err != nil {
		panic(err)
	}

	url := DatabaseURL()
	conn, err := pgx.Connect(context.Background(), url)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close(context.Background())

	app := fiber.New()

	app.Use(logger.New())

	app.Get("/ping", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{"msg": "pong"})
	})

  app.Get("/people", func(c *fiber.Ctx) error {
    rows, _ := conn.Query(context.Background(), "SELECT name as Name, age as Age FROM people;")

    var people []Person

    for rows.Next() {
      p := Person{}

      err := rows.Scan(&p.Name, &p.Age)
      if err != nil {
        fmt.Fprintf(os.Stderr, "rows.Scan failed: %v\n", err)
        os.Exit(1)
      }

      people = append(people, p)
    }
		
    return c.JSON(people)
  })

	addr := fmt.Sprintf(":%s", env.Get("PORT"))
	log.Fatal(app.Listen(addr))
}
