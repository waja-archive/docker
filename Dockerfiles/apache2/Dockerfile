#
# apache2 Dockerfile
#
# Pull base image (this is a stock stable image right from debootstrap)
FROM waja/debian:latest

# Predefine ENV
ENV PREDEF_WEB_PW f00b4r

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

# Install sshd and supervisor
RUN apt-get update && apt-get install --no-install-recommends -y openssh-server supervisor;\
 rm -rf /var/lib/apt/lists/ && \
 mkdir -p /var/run;\
 mkdir -p /var/run/sshd;\
 mkdir -p /var/log/supervisor && \
# Install apache2
 apt-get update && apt-get install --no-install-recommends -y apache2 && \
 rm -rf /var/lib/apt/lists/

# set root password
RUN echo "root:$PREDEF_WEB_PW" | chpasswd

# expose SSH
EXPOSE 22

# expose HTTP
EXPOSE 80

# Copy in supervisor config files
ADD supervisord/ /etc/supervisor/conf.d/

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]
