.PHONY: help install run dev test clean

help: ## Show available commands
	@grep -E '^[a-z]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-10s %s\n", $$1, $$2}'

install: ## Create .venv and install dependencies
	uv sync

run: ## Run the app
	uv run footnotes

dev: ## Run the API with auto-reload on http://localhost:8000
	uv run uvicorn footnotes.app:app --reload

test: ## Run tests
	uv run pytest

clean: ## Remove .venv and caches
	rm -rf .venv .pytest_cache
	find . -type d -name __pycache__ -prune -exec rm -rf {} +
