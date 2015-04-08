IMAGE_NAME := waja/icinga2
ICINGA_CONF_EXPORT_PATH := $(pwd)/conf.d

build:
	docker build --rm -t $(IMAGE_NAME) .
	
run:
	@echo docker run --rm -it -v $(ICINGA_CONF_EXPORT_PATH):/etc/icinga2/conf.d/docker/ $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v $(ICINGA_CONF_EXPORT_PATH):/etc/icinga2/conf.d/docker/ --entrypoint bash $(IMAGE_NAME) -l
