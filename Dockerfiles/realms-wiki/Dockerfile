FROM gliderlabs/alpine:3.3

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

RUN apk --update add python py-pip libldap && \
 apk --update add --virtual build-dependencies python-dev ca-certificates py-virtualenv zlib-dev libffi-dev yaml-dev openldap-dev cyrus-sasl-dev build-base wget && \
 pip install realms-wiki && \
 apk del build-dependencies

ADD realms-wiki.sh /usr/local/bin/realms-wiki.sh

# Prepare environment
# Deploy start script
RUN chmod +x /usr/local/bin/realms-wiki.sh && \
 # Create user
 adduser -D deploy && \
 # Create dir for logging
 mkdir /var/log/realms-wiki && chown deploy.deploy /var/log/realms-wiki && \
 # Hand over to deploy user
 chown -R deploy.deploy /home/deploy
 
EXPOSE 5000

CMD ["/usr/local/bin/realms-wiki.sh"]
