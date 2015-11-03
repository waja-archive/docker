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

# Download archive key
ADD http://deb.appserver.io/appserver.gpg /tmp/appserver.gpg

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
RUN apt-get update && apt-get install --no-install-recommends -y openssh-server supervisor wget;\
 rm -rf /var/lib/apt/lists/ && \
 mkdir -p /var/run;\
 mkdir -p /var/run/sshd;\
 mkdir -p /var/log/supervisor && \
 wget http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8_8c-2ubuntu8_amd64.deb -O /tmp/libjpeg8_8c-2ubuntu8_amd64.deb; \
 wget http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb -O /tmp/libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb; \
 dpkg -i /tmp/libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb /tmp/libjpeg8_8c-2ubuntu8_amd64.deb; \
# Install appserver
 echo "deb http://deb.appserver.io/ wheezy main" > /etc/apt/sources.list.d/appserver.list && \
 apt-key add /tmp/appserver.gpg && rm /tmp/appserver.gpg  && \
 apt-get update && apt-get install --no-install-recommends -y appserver-dist && \
# install missing dependency
 apt-get install --no-install-recommends -y libfreetype6 && \
# bind everything to 0.0.0.0 (FIXME)
 sed -i 's#                        <param name="address" type="string">127.0.0.1</param>#                        <param name="address" type="string">0.0.0.0</param>#' /opt/appserver/etc/appserver/appserver.xml && \
 rm -rf /var/lib/apt/lists/

# set root password
RUN echo "root:$PREDEF_WEB_PW" | chpasswd

# expose SSH and appserver
EXPOSE 22 9080 9433

# Copy in supervisor config files
ADD supervisord/ /etc/supervisor/conf.d/

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]
