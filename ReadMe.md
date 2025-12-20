# dbt project

Lightweight dbt project for local development and testing.

## Contents

- models/: dbt models (staging, marts, etc.)
- macros/: project macros and utilities
- seeds/, snapshots/, tests/
- packages.yaml: project package dependencies

## Prerequisites

- Python 3.10+ (or your environment's Python used for dbt)
- dbt (see `dbt --version`)
- A configured `~/.dbt/profiles.yml` with appropriate target connection

## Setup

1. Install project packages:

```powershell
dbt deps
```

2. Compile the project to validate models and YAML:

```powershell
dbt compile
```

3. Run tests for a model or the whole project:

```powershell
dbt test --models <model_name>
```

## Common tasks

- Run a single model: `dbt run --models <model_name>`
- Run full project: `dbt run`
- View compiled SQL: `target/compiled/`

## Notes

- This repo includes example staging models under `models/staging/`.
- If you update `packages.yaml`, rerun `dbt deps`.

## Contributing

1. Open an issue or PR describing changes.
2. Keep YAML tests in model `*.yml` files valid — follow dbt schema for tests.

---


