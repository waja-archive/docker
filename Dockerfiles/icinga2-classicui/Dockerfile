#
# Icinga2 Dockerfile (depends on apache2 image)
#
# For documentation about icinga2, see http://docs.icinga.org/icinga2/snapshot
#
# Pull base image
FROM waja/icinga2

# Predefine ENV
ENV PREDEF_WEB_PW f00b4r

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

# Download archive key
ADD http://debmon.org/debmon/repo.key /tmp/debmon_repo.key
ADD http://ftp.cyconet.org/debian/repo.key /tmp/cyconet_repo.key

# configure needed package sources
RUN echo "deb http://debmon.org/debmon debmon-jessie main" > /etc/apt/sources.list.d/debmon-jessie.list;\
 echo "deb http://httpredir.debian.org/debian/ jessie-backports main non-free contrib" > /etc/apt/sources.list.d/jessie-backports.list;\
 apt-key add /tmp/debmon_repo.key && apt-key add /tmp/cyconet_repo.key && \
 rm /tmp/debmon_repo.key /tmp/cyconet_repo.key && \
 apt-get update;\
 apt-get -y upgrade && \
 rm -rf /var/lib/apt/lists/

# prefine debconf questions
# enable external commands
RUN echo "icinga-common icinga/check_external_commands boolean true" | debconf-set-selections;\
# set icinga cgi admin password
 echo "icinga-cgi icinga/adminpassword password $PREDEF_WEB_PW" | debconf-set-selections;\
 echo "icinga-cgi icinga/adminpassword-repeat password $PREDEF_WEB_PW" | debconf-set-selections;\
# set icinga classic ui admin password
 echo "icinga2-classicui icinga2-classicui/adminpassword password $PREDEF_WEB_PW" | debconf-set-selections;\
 echo "icinga2-classicui icinga2-classicui/adminpassword-repeat password $PREDEF_WEB_PW" | debconf-set-selections

# package installation
RUN apt-get update && apt-get install -y icinga2-classicui;\
 rm -rf /var/lib/apt/lists/

# start init script to get environment initialised
RUN /etc/init.d/icinga2 start && /etc/init.d/icinga2 stop && \
 # set permissions to enable command pipe
 dpkg-statoverride --update --add nagios www-data 2710 /var/run/icinga2/cmd/icinga2.cmd

# Copy in supervisor config files
ADD supervisord/ /etc/supervisor/conf.d/

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]
