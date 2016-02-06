IMAGE_NAME := waja/jingo
JONGO_EXPORT_PATH := $$(pwd)/../../../jingo

build:
	docker build --rm -t $(IMAGE_NAME) .
	mkdir -p $(JONGO_EXPORT_PATH)/pelican-website
	
run:
	@echo docker run --rm -it -v $(JONGO_EXPORT_PATH):/srv -p 8080:8080 $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v $(JONGO_EXPORT_PATH):/srv --entrypoint bash -p 8080:8080 $(IMAGE_NAME) -l
