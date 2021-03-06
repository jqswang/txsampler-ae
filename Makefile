.PHONY: build start restart clean allclean

IMAGE_NAME = ae-ubuntu
INSTANCE_NAME = ae-test

build: Dockerfile
	sudo docker build -t $(IMAGE_NAME) .

start:
	mkdir -p mydata
	sudo docker run --cap-add sys_ptrace --cap-add sys_admin --security-opt seccomp=unconfined --name=$(INSTANCE_NAME) -v $(shell pwd)/mydata:/data -dit $(IMAGE_NAME)
	sudo docker attach $(INSTANCE_NAME) 

restart:
	sudo docker restart $(INSTANCE_NAME)
	sudo docker attach $(INSTANCE_NAME)

clean:
	sudo docker stop $(INSTANCE_NAME) || true
	sudo docker rm $(INSTANCE_NAME)

allclean:
	sudo docker container prune
