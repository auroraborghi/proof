# Python Backend

## Overview

The proof Python backend will ... TODO

This service is provided via Python's [FastAPI](https://fastapi.tiangolo.com/) client.
Benefits of FastAPI include:

* Auto-generated OpenAPI specification
* Web-hosted SwaggerUI to test endpoints & path operations
* Object-oriented API design
* More efficient and lightweight than other frameworks like Flask & Django (apologies for the potentially controversial statement peeps)

## Shortcut
To see what needs to be run in an easy to digest and Copy/Paste format, please see the install-dependencies.sh file.

## Quickstart [One Time Only]

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

Create a jupyter kernel based on the virtual environment:

```bash
python -m ipykernel install --prefix=/home/aborghi/.local --name proof
```

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

### Python Virtual Environment

To start the python virtual environment (venv):

```bash
cd ~/Developer/proof/backend
source .venv/proof/bin/activate
```

To stop the python venv:

```bash
deactivate
```

### FastAPI Python Server
**IMPORTANT:** Ensure that you are running the following command in the virtual python environment and are in the backend folder. 
This is done for you in the bash command block below for ease of use.

To start the FastAPI Python Server:

```bash
cd ~/Developer/proof/backend
source .venv/proof/bin/activate
cd tools/
python run.py
```

The OpenApi specification is automatically generated.
The SwaggerUI to view the OpenAPI specification is available at [localhost:8000/docs](http://localhost:8000/docs).

To save the OpenApi specification in `backend/`, do the following:

```bash
curl localhost:8000/docs/openapi.json > openapi.json
```

### Jupyter Lab
**IMPORTANT:** Ensure that you are running the following command in the virtual python environment and are in the backend folder. 
This is done for you in the bash command block below for ease of use.

To start jupyter lab:

```bash
cd ~/Developer/proof/backend
source .venv/proof/bin/activate
jupyter lab
```

Then go to [localhost:8888](http://localhost:8888/) on your preferred browser.

## Python and VSCode Setup
**IMPORTANT:** Remember to set your VSCode Python interpreter to the .venv/proof/bin/python file.

Install the following VSCode Extensions (updated on May 2022):
```bash
code --list-extensions | xargs -L 1 echo code --install-extension
code --install-extension alefragnani.project-manager
code --install-extension alexiv.vscode-angular2-files
code --install-extension codezombiech.gitignore
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension dbaeumer.vscode-eslint
code --install-extension docsmsft.docs-yaml
code --install-extension donjayamanne.git-extension-pack
code --install-extension donjayamanne.githistory
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension GrapeCity.gc-excelviewer
code --install-extension magicstack.MagicPython
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-vscode-remote.remote-containers
code --install-extension oderwat.indent-rainbow
code --install-extension redhat.vscode-commons
code --install-extension redhat.vscode-yaml
code --install-extension ziyasal.vscode-open-in-github.
```