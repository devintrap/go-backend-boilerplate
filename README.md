# Go Backend Boilerplate

A minimalist Go backend boilerplate with environment-based configuration and modern project structure.

## Features

- 🌍 Environment-based configuration (local, stage, prod)
- 📁 Clean project structure
- ⚙️ Configuration management with Viper
- 🛠️ Makefile for common operations
- 🚀 Quick setup script
- ✅ Test examples included

## Project Structure
```
.
├── bin/            # Compiled binaries
├── cmd/            # Main applications
│   └── main.go     # Application entry point
├── config/         # Configuration files
│   ├── local.toml
│   ├── stage.toml
│   └── prod.toml
├── internal/       # Private application code
│   └── config/     # Configuration package
├── pkg/           # Public library code
├── scripts/       # Scripts and tools
├── test/          # Additional test files
├── Makefile
└── README.md
```

## Prerequisites

- Go 1.21 or higher
- Make

## Quick Start

1. Clone the repository:
```bash
curl -L https://github.com/devintrap/go-backend-boilerplate/archive/refs/tags/latest.zip -o go-backend-boilerplate.zip
unzip go-backend-boilerplate.zip
mv go-backend-boilerplate-latest your-project-name
cd your-project-name
```

2. Initialize your project:
```bash
make setup NAME=your-project-name
```

3. Run the application:
```bash
make run           # Run with local config
make run ENV=stage # Run with staging config
make run ENV=prod  # Run with production config
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the application |
| `make run` | Run the application |
| `make test` | Run tests |
| `make clean` | Clean build files |
| `make coverage` | Generate test coverage |
| `make fmt` | Format code |
| `make lint` | Run linter |
| `make setup NAME=<name>` | Initialize project |

## Configuration

Configuration files are in TOML format and located in the `config/` directory:

```toml
# Example config/local.toml
environment = "local"

[logger]
level = "debug"
format = "console"
```

Set the environment using the `ENV` variable:
```bash
ENV=prod make run
```

## Testing

Run all tests:
```bash
make test
```

Generate coverage report:
```bash
make coverage
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.