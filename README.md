# pglint/action

> [GitHub Action](https://help.github.com/en/actions) for running [PGLint](https://pglint.com) database checks.

## Example

```yaml
name: Database checks

on: [push]

jobs:
  pglint:
    runs-on: ubuntu-16.04

    env:
      DATABASE_URL: postgres://postgres:postgres@localhost:5432/postgres

    services:
      postgres:
        image: postgres:12
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: postgres
        ports:
          - "0.0.0.0:5432:5432"
        # needed because the postgres container does not provide a healthcheck
        options:
          --health-cmd pg_isready --health-interval 10s --health-timeout 5s
          --health-retries 5

    steps:
      - name: "Checkout"
        uses: actions/checkout@v1
      - name: "Load database schema"
        run: psql -f my_database_schema.sql "$DATABASE_URL"
      - name: "Run PGLint checks"
        uses: pglint/action
```
