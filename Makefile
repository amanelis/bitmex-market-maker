.PHONY: docs test

VIRTUALENV = $(shell which virtualenv)

clean:
	rm -rf *.egg-info/
	rm -rf .cache/
	rm -rf .tox/
	rm .coverage || true
	rm -rf build
	rm -rf dist
	rm -rf htmlcov
	rm -rf venv
	find . -type d -name '__pycache__' | xargs rm -rf
	find . -name "*.pyc" -type f -print0 | xargs -0 /bin/rm -rf

compile:
	. venv/bin/activate; python setup.py build install

console:
	. venv/bin/activate; python

coverage:
	. venv/bin/activate; coverage run --source src setup.py test
	. venv/bin/activate; coverage html
	. venv/bin/activate; coverage report

deps:
	. venv/bin/activate; python -m pip install -r requirements.txt

install: clean venv deps
	. venv/bin/activate; python setup.py install

launch:
	. venv/bin/activate; ./marketmaker

venv:
	$(VIRTUALENV) -p python3 venv
