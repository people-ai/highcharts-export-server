PROJECT	   	?= highcharts
BUILD_TAG  	?= $(shell cat $(CURDIR)/.version)
BUILD_HOST	?=
BUILD_POSTFIX	?=

# ==============
#  Bump version
# ==============

.PHONY: release
VERSION?=minor
# target: release - Bump version
release:
	@git up
	@pip install bumpversion
	@bumpversion $(VERSION)
	@git checkout master
	@git merge develop
	@git checkout develop
	@git push origin develop master
	@git push --tags

.PHONY: minor
minor: release

.PHONY: patch
patch:
	make release VERSION=patch

.PHONY: major
major:
	make release VERSION=major

# =============
#  Docker
# =============

.PHONY: docker
docker:
	docker build -t $(PROJECT)$(BUILD_POSTFIX):$(BUILD_TAG) $(CURDIR)
	[ ! -z "$(BUILD_HOST)" ] && docker tag $(PROJECT)$(BUILD_POSTFIX):$(BUILD_TAG) $(BUILD_HOST)$(PROJECT)$(BUILD_POSTFIX):$(BUILD_TAG)  || true
	[ ! -z "$(BUILD_HOST)" ] && docker pull $(PROJECT)$(BUILD_POSTFIX):$(BUILD_TAG) || true

RUN = 
.PHONY: docker-run
docker-run: 
	@docker run --rm -it -p 80:3003 --name $(PROJECT) $(PROJECT)$(BUILD_POSTFIX):$(BUILD_TAG) $(RUN)

docker-clean: 
	@docker rm -v $(shell docker ps -aq -f status=exited) || true
	@docker rm -v $(shell docker ps -aq --no-trunc) || true
	@docker rmi $(shell docker images -f dangling=true -q) || true

.PHONY: deploy
deploy:
	rm -rf .deploy
	git clone git@github.com:people-ai/infra-v2.git .deploy
	cd .deploy && make install deploy

-include .deploy/Makefile

