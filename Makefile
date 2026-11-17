.PHONY: help install run dev test db db-down migrate migration docker-build docker-run clean

help: ## Show available commands
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-14s %s\n", $$1, $$2}'

install: ## Create .venv and install dependencies
	uv sync

run: ## Run the app
	uv run footnotes

dev: ## Run the API with auto-reload on http://localhost:8000
	uv run uvicorn footnotes.app:app --reload

test: ## Run tests
	uv run pytest

db: ## Start PostgreSQL in Docker (in the background)
	docker compose up -d --wait db

db-down: ## Stop Docker containers (database data is kept)
	docker compose down

migrate: ## Apply database migrations
	uv run alembic upgrade head

migration: ## Create a migration from model changes: make migration m="add users"
	uv run alembic revision --autogenerate -m "$(m)"

docker-build: ## Build the Docker image
	docker build -t footnotes .

docker-run: ## Run API + PostgreSQL in Docker on http://localhost:8000
	docker compose up --build

clean: ## Remove .venv and caches
	rm -rf .venv .pytest_cache
	find . -type d -name __pycache__ -prune -exec rm -rf {} +
