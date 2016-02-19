DOCKER_REPO="esselius/fluentd-docker-metrics"
SHORT_SHA="$(shell git rev-parse --short HEAD)"

.PHONY: push
push:
	docker build -t "${DOCKER_REPO}:${SHORT_SHA}"
	docker push "${DOCKER_REPO}:${SHORT_SHA}"
