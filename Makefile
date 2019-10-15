IMAGE_NAME := quay.io/app-sre/s3-reload
IMAGE_TAG := $(shell git rev-parse --short=7 HEAD)

ifneq (,$(wildcard $(CURDIR)/.docker))
	DOCKER_CONF := $(CURDIR)/.docker
else
	DOCKER_CONF := $(HOME)/.docker
endif


.PHONY: build
build:
	@docker build -t $(IMAGE_NAME):latest .
	@docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: push
push:
	@docker --config=$(DOCKER_CONF) push $(IMAGE_NAME):latest
	@docker --config=$(DOCKER_CONF) push $(IMAGE_NAME):$(IMAGE_TAG)
