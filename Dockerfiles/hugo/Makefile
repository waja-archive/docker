IMAGE_NAME := waja/hugo
HUGO_EXPORT_PATH := $$(pwd)/../../../hugo

build:
	docker build --rm -t $(IMAGE_NAME) .
	
run:
	@echo docker run --rm -it -v $(HUGO_EXPORT_PATH):/srv $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v $(HUGO_EXPORT_PATH):/srv --entrypoint bash $(IMAGE_NAME) -l
