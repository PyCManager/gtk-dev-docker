all: build

.PHONY: build
build:
	docker build -t eldorplus/docker-gtk:latest -f .docker/Dockerfile .
	@echo ::: built :::

.PHONY: run
run:
	winpty docker run -ti --rm -e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix eldorplus/gtk-dev-docker:latest

.PHONY: push
push:
	docker push eldorplus/gtk-dev-docker:latest

.PHONY: clean
clean:
	@echo ::: cleaned :::
