build:
	docker build -t dldw:latest .

run:
	docker run -d --privileged -p 2222:22 dldw /usr/sbin/sshd -D

debug:
	docker run -it -p 2222:22 dldw /usr/sbin/sshd -d

tag:
	docker tag dldw:latest conorturner/dldw:latest

push:
	docker push conorturner/dldw:latest

.PHONY: build run tag push
