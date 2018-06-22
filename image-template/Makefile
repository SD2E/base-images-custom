export CONTAINER_IMAGE ?= sd2e/reactors-python2:<tagname>
PYTEST_OPTS ?= "-s -vvv"
PYTEST_DIR ?= "tests"

all: image
	true

image:
	docker build -f Dockerfile -t $(CONTAINER_IMAGE) .

shell:
	bash scripts/run_container_process.sh bash

tests: tests-pytest

tests-pytest:
	bash scripts/run_container_process.sh pytest $(PYTEST_DIR) $(PYTEST_OPTS)

deploy:
	docker push $(CONTAINER_IMAGE)

clean-image:
	docker rmi -f $(CONTAINER_IMAGE)

clean-tests:
	rm -rf .pytest_cache tests/__pycache__ .coverage .hypothesis *.pyc

clean: clean-image clean-tests
