import pytest
from fastapi.testclient import TestClient

from footnotes.app import app
from footnotes.db import get_session


@pytest.fixture
def client():
    with TestClient(app) as client:
        yield client
    app.dependency_overrides.clear()


def test_root_redirects_to_docs(client):
    response = client.get("/", follow_redirects=False)
    assert response.status_code == 307
    assert response.headers["location"] == "/docs"


def test_health_with_database(client):
    """Needs PostgreSQL running: make db"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "database": "ok"}


def test_health_reports_unavailable_database(client):
    class BrokenSession:
        async def execute(self, *args, **kwargs):
            raise OSError("connection refused")

    async def broken_session():
        yield BrokenSession()

    app.dependency_overrides[get_session] = broken_session

    response = client.get("/health")
    assert response.status_code == 503
    assert response.json() == {"status": "error", "database": "unavailable"}


def test_hello_default(client):
    response = client.get("/hello")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello, world!"}


def test_hello_with_name(client):
    response = client.get("/hello", params={"name": "Footnotes"})
    assert response.json() == {"message": "Hello, Footnotes!"}
