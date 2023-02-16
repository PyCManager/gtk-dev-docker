all: build

.PHONY: build
build:
	docker build -t eldorplus/docker-gtk:latest -f deployment/Dockerfile .
	@echo ::: built :::

.PHONY: run
run:
	winpty docker run -ti --rm -e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix:/tmp/.X11-unix eldorplus/docker-gtk:latest

.PHONY: push
push:
	docker push eldorplus/docker-gtk:latest

.PHONY: clean
clean:
	@echo ::: cleaned :::
