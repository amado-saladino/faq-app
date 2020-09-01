info: usage

PWD := $(shell pwd)

usage:
	@echo " create image            Create Image."
	@echo " make build              Build dependencies."
	@echo " make run                Start the server."
	@echo " make test               Runs all jest tests."
	@echo " make logs               Application logs."

create: create_image
build: do_build
run: do_run
test: do_tests
logs: do_logs

create_image:
	docker build --tag=app .

do_build:
	docker-compose down -v
	docker-compose build
	docker run  --name=backend -d app -p 12000:3000  yarn install&&yarn start
	docker run  --name=frontend -d app -p 8000:3000  yarn install&&yarn start

do_logs:
	docker-compose logs --tail=5 -f

do_run:
	docker start backend 
	docker start frontend

do_tests:
	docker run -w=/app -v=$(PWD)/backend/:/app node:lts-alpine yarn test
	docker run -w=/app -v=$(PWD)/frontend/:/app node:lts-alpine yarn test
