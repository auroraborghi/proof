.PHONY: init venv install update lint style-lint all-lint test build

init: venv install

venv:
	python3.10 -m venv .venv/proof

install:
	.venv/proof/bin/pip install --upgrade pip pip-tools setuptools wheel
	.venv/proof/bin/python -m pip install -r requirements.txt -r requirements-dev.txt

update:
	.venv/proof/bin/pip-compile --no-emit-index-url --no-emit-trusted-host
	.venv/proof/bin/pip-compile --no-emit-index-url --no-emit-trusted-host requirements-dev.in > requirements-dev.txt
	.venv/proof/bin/pip-sync requirements.txt requirements-dev.txt

build:
	rm -rf build/ dist/ proof.egg-info/
	.venv/proof/bin/python setup.py install
	.venv/proof/bin/python setup.py bdist_wheel

lint:
	find . -type f -not -path "./.venv/*" -not -path "./build/*" -name \*.py | xargs .venv/proof/bin/pylint --disable R,C,I

style-lint:
	find . -type f -not -path "./.venv/*" -not -path "./build/*" -name \*.py | xargs .venv/proof/bin/pycodestyle --max-line-length 120

all-lint: lint style-lint

test:
	PYTHONPATH=./ .venv/proof/bin/pytest -p no:warnings test/
