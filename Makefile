define HELP_MESSAGE =
Make targets:

Common:

  help - Show this message and exit.

Docker commands:
  docker/build                  - Build docker images
  docker/up                     - Start docker environment in detached mode.
  docker/logs                   - Display docker environment logs.
  docker/down                   - Stop and remove containers.
  docker/destroy                - Stop and remove containers and data volumes.
  docker/run-migrations         - Run migrations in docker environment.

endef
export HELP_MESSAGE

.PHONY: help
help:
	@echo "$$HELP_MESSAGE"

# Docker commands

.PHONY: docker/build
docker/build:
	docker-compose build

.PHONY: docker/rebuild
docker/rebuild:
	docker-compose build --no-cache

.PHONY: docker/up
docker/up:
	docker-compose up --build -d

.PHONY: docker/logs
docker/logs:
	docker-compose logs -f

.PHONY: docker/down
docker/down:
	docker-compose down

.PHONY: docker/destroy
docker/destroy:
	docker-compose down --volumes

.PHONY: docker/run-migrations
docker/run-migrations:
	docker-compose run --rm pulp-api manage migrate
	docker-compose run --rm galaxy-api manage migrate

.PHONY: kompose/convert-ci
kompose/convert-ci:
	cd openshift/ci && kompose -f ../../production-ci.yml --provider OpenShift convert

.PHONY: docker/build-ci
docker/build-ci:
	docker-compose -f production-ci.yml build

.PHONY: docker/push-ci
docker/push-ci:
	docker-compose -f production-ci.yml push

.PHONY: kompose/convert-prod
kompose/convert-prod:
	cd openshift/prod && kompose -f ../../production-prod.yml --provider OpenShift convert

.PHONY: docker/build-prod
docker/build-prod:
	docker-compose -f production-prod.yml build

.PHONY: docker/push-prod
docker/push-prod:
	docker-compose -f production-prod.yml push
