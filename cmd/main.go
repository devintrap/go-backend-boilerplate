package main

import (
	"fmt"
	"log"

	"github.com/devintrap/go-backend-boilerplate/internal/config"
)

func main() {
	cfg, err := config.LoadConfig()
	if err != nil {
		log.Fatalf("Failed to load config: %v", err)
	}

	fmt.Printf("Environment: %s\n", cfg.Environment)
}
