#
# apache2 Dockerfile
#
# Pull base image (this is a stock stable image right from debootstrap)
FROM waja/debian:latest

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ENV DEBIAN_FRONTEND noninteractive

# Disable installation of Recommends
RUN echo 'Aptitude::Recommends-Important "False";' > /etc/apt/apt.conf.d/10norecommands && \
# configure locale
 apt-get update && apt-get install --no-install-recommends locales && \
 rm -rf /var/lib/apt/lists/ && \
 dpkg-reconfigure locales && \
 locale-gen C.UTF-8 && \
 /usr/sbin/update-locale LANG=C.UTF-8 && \
# configure timezone
 echo "Europe/Prague" > /etc/timezone && \
 dpkg-reconfigure -f non-interactive tzdata	

ENV LC_ALL C.UTF-8

# Install dependencies for building httpdiff 
RUN apt-get update && \
 apt-get install -y --no-install-recommends git golang-go ca-certificates;\
 rm -rf /var/lib/apt/lists/ && \
# Install httpdiff client
 echo "Starting installing httpdiff." && \
 go get github.com/jgrahamc/httpdiff && \
 go install github.com/jgrahamc/httpdiff 

ENTRYPOINT ["/usr/lib/go/bin/httpdiff"]
#CMD [""]
