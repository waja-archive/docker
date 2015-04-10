IMAGE_NAME := waja/pelican
PELICAN_EXPORT_PATH := $$(pwd)/../../../pelican

build:
	docker build --rm -t $(IMAGE_NAME) .
	mkdir -p $(PELICAN_EXPORT_PATH)/pelican-website
	
run:
	@echo docker run --rm -it -v $(PELICAN_EXPORT_PATH):/srv -p 8000:8000 $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v $(PELICAN_EXPORT_PATH):/srv --entrypoint bash -p 8000:8000 $(IMAGE_NAME) -l
