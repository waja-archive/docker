#
# virt-manager Dockerfile
#
# Pull base image (this is a stock stable image right from debootstrap)
#FROM waja/debian:latest
FROM debian:jessie

# Predefine ENV
#ENV PREDEF_WEB_PW f00b4r

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

# Disable installation of Recommends
RUN echo 'Aptitude::Recommends-Important "False";' > /etc/apt/apt.conf.d/10norecommands

# update package list
RUN apt-get update

# configure locale
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install --no-install-recommends locales && \
 dpkg-reconfigure locales && \
 locale-gen C.UTF-8 && \
 /usr/sbin/update-locale LANG=C.UTF-8
ENV LC_ALL C.UTF-8

# configure timezone
RUN echo "Europe/Prague" > /etc/timezone && \
 dpkg-reconfigure -f non-interactive tzdata	

# needs to be fixed for OSX: https://github.com/docker/docker/issues/8710
ENV DISPLAY unix$DISPLAY

RUN apt-get install -y --no-install-recommends \
    virt-manager \
    ssh \
    ssh-askpass-gnome

ENTRYPOINT /usr/bin/virt-manager --no-fork
