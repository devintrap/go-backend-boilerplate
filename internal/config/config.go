package config

import (
	"fmt"
	"os"

	"github.com/spf13/viper"
)

type Config struct {
	Environment string
	Logger      LoggerConfig
}

type LoggerConfig struct {
	Level  string
	Format string
}

func LoadConfig() (*Config, error) {
	env := os.Getenv("ENV")
	if env == "" {
		env = "local"
	}

	// Validate environment
	switch env {
	case "local", "stage", "prod":
		// valid environments
	default:
		return nil, fmt.Errorf("invalid environment: %s", env)
	}

	viper.SetConfigName(env)
	viper.SetConfigType("toml")
	viper.AddConfigPath("config")

	if err := viper.ReadInConfig(); err != nil {
		return nil, fmt.Errorf("error reading config file: %w", err)
	}

	var config Config
	if err := viper.Unmarshal(&config); err != nil {
		return nil, fmt.Errorf("error unmarshaling config: %w", err)
	}

	return &config, nil
}
