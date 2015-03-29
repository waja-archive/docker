IMAGE_NAME := waja/caff-cli

#-include .settings

build:
	docker build --rm -t $(IMAGE_NAME) .
	
run:
	@echo docker run --rm -it -v ${HOME}/.caff/keys/:/home/user/.caff/keys/ -v ${HOME}/.gnupg/:/home/user/.gnupg/:ro -v ${HOME}/.msmtprc:/home/user/.msmtprc:ro -v ${HOME}/.caffrc:/home/user/.caffrc:ro $(IMAGE_NAME) 
	
shell:
	docker run --rm -it -v ${HOME}/.caff/keys/:/home/user/.caff/keys/ -v ${HOME}/.gnupg/:/home/user/.gnupg/:ro -v ${HOME}/.msmtprc:/home/user/.msmtprc:ro -v ${HOME}/.caffrc:/home/user/.caffrc:ro --entrypoint bash $(IMAGE_NAME) -l
