#
# apache2 Dockerfile
#
# Pull base image
FROM waja/debian:latest

# Predefine ENV
ENV PREDEF_WEB_PW f00b4r

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

# Disable installation of Recommends
RUN echo 'Aptitude::Recommends-Important "False";' > /etc/apt/apt.conf.d/10norecommands

# Install sshd and supervisor
RUN apt-get install --no-install-recommends -y openssh-server supervisor;\
 mkdir -p /var/run/sshd;\
 mkdir -p /var/run/supervisord;\
 mkdir -p /var/log/supervisord
# set root password
RUN echo "root:$PREDEF_WEB_PW" | chpasswd

# expose SSH
EXPOSE 22

# Install apache2
RUN apt-get install --no-install-recommends -y apache2

# expose HTTP
EXPOSE 80

# Copy in supervisor config files
ADD supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]
