.PHONY: help install dev build test clean docker-build docker-up docker-down docker-logs

# Default target
help:
	@echo "Available commands:"
	@echo "  install       - Install all dependencies"
	@echo "  dev           - Start development servers"
	@echo "  build         - Build frontend for production"
	@echo "  test          - Run all tests"
	@echo "  clean         - Clean build artifacts"
	@echo "  docker-build  - Build Docker images"
	@echo "  docker-up     - Start all services with Docker"
	@echo "  docker-down   - Stop all Docker services"
	@echo "  docker-logs   - Show Docker logs"
	@echo "  seed          - Create sample API key"

# Install dependencies
install:
	@echo "Installing backend dependencies..."
	cd backend && pip install -r requirements.txt
	@echo "Installing frontend dependencies..."
	cd frontend && npm install

# Development servers
dev:
	@echo "Starting development servers..."
	@echo "Backend will run on http://localhost:8000"
	@echo "Frontend will run on http://localhost:3000"
	@make -j2 dev-backend dev-frontend

dev-backend:
	cd backend && python main.py

dev-frontend:
	cd frontend && npm run dev

# Build for production
build:
	@echo "Building frontend for production..."
	cd frontend && npm run build

# Run tests
test:
	@echo "Running backend tests..."
	cd backend && python -m pytest tests/ -v
	@echo "Running frontend tests..."
	cd frontend && npm run type-check

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf backend/__pycache__
	rm -rf backend/app/__pycache__
	rm -rf backend/uploads/*
	rm -rf backend/processed/*
	rm -rf frontend/dist
	rm -rf frontend/node_modules/.cache

# Docker commands
docker-build:
	@echo "Building Docker images..."
	docker-compose build

docker-up:
	@echo "Starting services with Docker..."
	docker-compose up -d
	@echo "Services started!"
	@echo "Frontend: http://localhost:3000"
	@echo "Backend API: http://localhost:8000"
	@echo "API Docs: http://localhost:8000/docs"

docker-down:
	@echo "Stopping Docker services..."
	docker-compose down

docker-logs:
	docker-compose logs -f

# Create sample API key
seed:
	@echo "Creating sample API key..."
	curl -X POST http://localhost:8000/api/v1/api-keys \
		-H "Content-Type: application/json" \
		-d '{"name": "Development Key", "rate_limit_per_minute": 100}' \
		| python -m json.tool

# Format code
format:
	@echo "Formatting backend code..."
	cd backend && python -m black .
	cd backend && python -m ruff check . --fix
	@echo "Formatting frontend code..."
	cd frontend && npm run lint -- --fix

# Check code quality
lint:
	@echo "Checking backend code..."
	cd backend && python -m black --check .
	cd backend && python -m ruff check .
	@echo "Checking frontend code..."
	cd frontend && npm run lint
	cd frontend && npm run type-check