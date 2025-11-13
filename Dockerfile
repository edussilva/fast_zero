FROM python:3.12-slim
ENV POETRY_VIRTUALENVS_CREATE=false

WORKDIR app/
COPY ["alembic.ini", "poetry.lock", "pyproject.toml", "./"]

RUN pip install poetry

COPY . .
RUN chmod +x entrypoint.sh
RUN poetry config installer.max-workers 10
RUN poetry install --no-interaction --no-ansi --without dev


EXPOSE 8000
CMD poetry run uvicorn --host 0.0.0.0 fast_zero.app:app
