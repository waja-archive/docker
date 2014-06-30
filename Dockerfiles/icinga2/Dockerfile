#
# Icinga2 Dockerfile (depends on apache2 image)
#
# For documentation about icinga2, see http://docs.icinga.org/icinga2/snapshot
#
# Pull base image
FROM waja/debian_apache2:wheezy

# Predefine ENV
ENV PREDEF_WEB_PW f00b4r

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

# configure needed package sources
RUN echo "deb http://debmon.org/debmon debmon-wheezy main" > /etc/apt/sources.list.d/debmon-wheezy.list;\
 echo "deb http://cdn.debian.net/debian/ wheezy-backports main non-free contrib" > /etc/apt/sources.list.d/wheezy-backports.list;\
 apt-get install --no-install-recommends -y wget;\
 wget -O - http://debmon.org/debmon/repo.key | apt-key add -;\
 apt-get update;\
 apt-get -y upgrade

# prefine debconf questions
# enable external commands
RUN echo "icinga-common icinga/check_external_commands boolean true" | debconf-set-selections

# set icinga cgi admin password
RUN echo "icinga-cgi icinga/adminpassword password $PREDEF_WEB_PW" | debconf-set-selections;\
 echo "icinga-cgi icinga/adminpassword-repeat password $PREDEF_WEB_PW" | debconf-set-selections
# set icinga classic ui admin password
RUN echo "icinga2-classicui icinga2-classicui/adminpassword password $PREDEF_WEB_PW" | debconf-set-selections;\
 echo "icinga2-classicui icinga2-classicui/adminpassword-repeat password $PREDEF_WEB_PW" | debconf-set-selections

# package installation
RUN apt-get install -y -t wheezy-backports icinga2-classicui icinga2;\
# nagios plugins from debian
 apt-get install -y -t wheezy-backports nagios-plugins-basic;\
 apt-get install -y -t wheezy-backports --no-install-recommends nagios-plugins-standard nagios-snmp-plugins;\
# install dependencies for nagios-plugins-standard
 apt-get install -y -t wheezy-backports --no-install-recommends  dnsutils snmp libmysqlclient18;\
# install dependencies for nagios-snmp-plugins
 apt-get install -y -t wheezy-backports --no-install-recommends netbase;\
# (unofficial) monitoring-plugins-cyconet
 echo "deb     http://ftp.cyconet.org/debian restricted     main non-free contrib" > /etc/apt/sources.list.d/restricted-cyconet.list;\
 apt-get update;\
 apt-get install -y --force-yes --no-install-recommends monitoring-plugins-cyconet


# start init script to get environment initialised
RUN /etc/init.d/icinga2 start && /etc/init.d/icinga2 stop

# enable icinga feature
RUN icinga2-enable-feature perfdata syslog

# Copy in supervisor config files
ADD supervisord/ /etc/supervisor/conf.d/

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]
