.PHONY: help install run dev test clean docker-build docker-run

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

docker-build: ## Build the Docker image
	docker build -t footnotes .

docker-run: ## Run the Docker image on http://localhost:8000
	docker run --rm -p 8000:8000 footnotes

clean: ## Remove .venv and caches
	rm -rf .venv .pytest_cache
	find . -type d -name __pycache__ -prune -exec rm -rf {} +
