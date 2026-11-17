import pytest
from fastapi.testclient import TestClient

from footnotes.app import app


@pytest.fixture
def client():
    return TestClient(app)


def test_root_redirects_to_docs(client):
    response = client.get("/", follow_redirects=False)
    assert response.status_code == 307
    assert response.headers["location"] == "/docs"


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_hello_default(client):
    response = client.get("/hello")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello, world!"}


def test_hello_with_name(client):
    response = client.get("/hello", params={"name": "Footnotes"})
    assert response.json() == {"message": "Hello, Footnotes!"}
