IMAGE_NAME := waja/realms-wiki
REALMS_EXPORT_PATH := $$(pwd)/../../../realms-wiki

build:
	docker build --rm -t $(IMAGE_NAME) .
	mkdir -p $(REALMS_EXPORT_PATH)/pelican-website
	
run:
	@echo docker run --rm -it -v $(REALMS_EXPORT_PATH):/srv -p 5000:5000 $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v $(REALMS_EXPORT_PATH):/srv --entrypoint bash -p 5000:5000 $(IMAGE_NAME) -l
