# Footnotes

Routes shared by friends: describe a walk or a trip in your own words, attach photos, and let an AI agent turn it into steps with real places that friends can find, comment on and improve.

> Early stage. Right now the project is a FastAPI skeleton with tests.

## Stack

- Python 3.12, managed with [uv](https://docs.astral.sh/uv/)
- [FastAPI](https://fastapi.tiangolo.com/) served by uvicorn
- PostgreSQL 17 (in Docker), SQLAlchemy 2 (async, asyncpg), Alembic migrations
- pytest for tests

## Getting started

Install [uv](https://docs.astral.sh/uv/getting-started/installation/) (it downloads Python 3.12 automatically) and Docker Desktop (for PostgreSQL).

```sh
make install   # create .venv and install dependencies
make db        # start PostgreSQL in Docker
make migrate   # apply database migrations
make dev       # start the API with auto-reload
```

Settings come from environment variables or a `.env` file (see `.env.example`). The defaults already match the database from `compose.yaml`, so `.env` is optional locally.

Then open http://localhost:8000/docs for the interactive API docs.

## Commands

| Command        | What it does                                  |
| -------------- | --------------------------------------------- |
| `make install` | Create `.venv` and install dependencies       |
| `make dev`     | Run the API on http://localhost:8000 with reload |
| `make run`     | Run the CLI entry point (prints a greeting)   |
| `make test`    | Run the test suite (needs `make db`)          |
| `make db`      | Start PostgreSQL in Docker                    |
| `make db-down` | Stop Docker containers, keep the data         |
| `make migrate` | Apply database migrations                     |
| `make migration m="..."` | Create a migration from model changes |
| `make docker-build` | Build the Docker image `footnotes`       |
| `make docker-run`   | Run API + PostgreSQL in Docker on http://localhost:8000 |
| `make clean`   | Remove `.venv` and caches                     |
| `make help`    | List all commands                             |

## API

| Method | Path      | Description                          |
| ------ | --------- | ------------------------------------ |
| GET    | `/`       | Redirects to `/docs`                 |
| GET    | `/health` | Health check incl. database, 503 if the database is down |
| GET    | `/hello`  | Greeting, optional `?name=` query    |

## Project structure

```
src/footnotes/
  __init__.py   # greet() and CLI entry point
  app.py        # FastAPI app and routes
  config.py     # settings from env / .env
  db.py         # SQLAlchemy engine, session, Base for models
migrations/     # Alembic migrations
tests/          # pytest tests
compose.yaml    # PostgreSQL (and the API) for local Docker
pyproject.toml  # project metadata, dependencies, tool config
uv.lock         # locked dependency versions
```

## Dependencies

```sh
uv add <package>          # runtime dependency
uv add --dev <package>    # dev-only dependency
```

Commit `uv.lock` together with `pyproject.toml`.
