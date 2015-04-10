#
# apache2 Dockerfile
#
# Pull base image (this is a stock stable image right from debootstrap)
FROM waja/debian:latest
#FROM debian:jessie

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ENV DEBIAN_FRONTEND noninteractive
ENV HUGO_VERSION 0.13

# Download Hugo binary package
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_amd64.deb /tmp/

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

# Install dependencies for building Hugo 
RUN apt-get update && \
 apt-get install -y --no-install-recommends python-pygments;\
 rm -rf /var/lib/apt/lists/ && \
# Installing Hugo
 dpkg -i /tmp/hugo_${HUGO_VERSION}_amd64.deb && \
 rm /tmp/hugo_${HUGO_VERSION}_amd64.deb

EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["-w", "-s", "/srv/blog_src", "-d", "/srv/blog_output"]
