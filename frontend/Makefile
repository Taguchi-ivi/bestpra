.PHONY: version docker-local docker-prod down clean

export APP_VERSION ?= $(shell git rev-parse --short HEAD)
include ../.env

version:
	@ echo ${ECR_REPOURL}
	@ echo '{"Version": "$(APP_VERSION)"}'

docker-local:
	docker-compose build --no-cache
	docker-compose up

docker-prod:
	docker-compose -f docker-compose.prod.yml build
	docker-compose -f docker-compose.prod.yml run web rails db:create
	docker-compose -f docker-compose.prod.yml run web rails db:migrate
	docker-compose up

down:
	docker-compose down -v

clean:
	docker system prune