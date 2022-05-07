# Python Backend

## Overview

The proof Python backend will ... TODO

This service is provided via Python's [FastAPI](https://fastapi.tiangolo.com/) client.
Benefits of FastAPI include:

* Auto-generated OpenAPI specification
* Web-hosted SwaggerUI to test endpoints & path operations
* Object-oriented API design
* More efficient and lightweight than other frameworks like Flask & Django (apologies for the potentially controversial statement peeps)

## Quickstart

Create a development virtual environment with dependencies installed:

```bash
make init
```

Activate the development virtual environment and test the local build:

```bash
source .venv/proof/bin/activate
ipython

Python 3.10.4 (main, May  7 2022, 14:01:23) [GCC 8.5.0 20210514 (Red Hat 8.5.0-13)]
Type 'copyright', 'credits' or 'license' for more information
IPython 8.3.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: 

In [1]: import proof

In [2]:
```

**IMPORTANT:** This import should succeed.

## Common Operations

### Build Code Changes

To build local code changes in `proof/` into the development virtual environment:

```bash
make build
```

### Add New Dependencies

For dependencies that are required for the proof service build, add names of required
modules to `install_requires` in `setup.cfg` **in alphabetical order**. Then, regenerate
lockfile (`requirements.txt`) for dependencies with `make update`.

```bash
make update
```

For dependencies that are required for the proof service development build, add names of 
required modules to `requirements-dev.in` **in alphabetical order**. Then, regenerate lockfiles (`requirements.txt` and `requirements-dev.txt`) with `make update`.

```bash
make update
```

Upon calls to `make update`, new versions of dependencies as specified in lockfiles are
installed into the development virtual environment automatically.

### Lint Code

To lint code for common errors:

```bash
make lint
```

To lint code for [PEP8](https://peps.python.org/pep-0008/) style:

```bash
make style-lint
```

To lint code for both common errors and style:

```bash
make all-lint
```

### Test Code

To execute unit tests:

```bash
make test
```