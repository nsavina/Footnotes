# Footnotes

Routes shared by friends: describe a walk or a trip in your own words, attach photos, and let an AI agent turn it into steps with real places that friends can find, comment on and improve.

> Early stage. Right now the project is a FastAPI skeleton with tests.

## Stack

- Python 3.12, managed with [uv](https://docs.astral.sh/uv/)
- [FastAPI](https://fastapi.tiangolo.com/) served by uvicorn
- pytest for tests

## Getting started

Install [uv](https://docs.astral.sh/uv/getting-started/installation/). It downloads Python 3.12 automatically if it is missing.

```sh
make install   # create .venv and install dependencies
make dev       # start the API with auto-reload
```

Then open http://localhost:8000/docs for the interactive API docs.

## Commands

| Command        | What it does                                  |
| -------------- | --------------------------------------------- |
| `make install` | Create `.venv` and install dependencies       |
| `make dev`     | Run the API on http://localhost:8000 with reload |
| `make run`     | Run the CLI entry point (prints a greeting)   |
| `make test`    | Run the test suite                            |
| `make clean`   | Remove `.venv` and caches                     |
| `make help`    | List all commands                             |

## API

| Method | Path      | Description                          |
| ------ | --------- | ------------------------------------ |
| GET    | `/`       | Redirects to `/docs`                 |
| GET    | `/health` | Health check, returns `{"status": "ok"}` |
| GET    | `/hello`  | Greeting, optional `?name=` query    |

## Project structure

```
src/footnotes/
  __init__.py   # greet() and CLI entry point
  app.py        # FastAPI app and routes
tests/          # pytest tests
pyproject.toml  # project metadata, dependencies, tool config
uv.lock         # locked dependency versions
```

## Dependencies

```sh
uv add <package>          # runtime dependency
uv add --dev <package>    # dev-only dependency
```

Commit `uv.lock` together with `pyproject.toml`.
