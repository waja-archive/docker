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
 echo "deb http://cdn.debian.net/debian/  wheezy-backports-sloppy main non-free contrib" > /etc/apt/sources.list.d/wheezy-backports-sloppy-cyconet.list;\
 apt-get update && apt-get install --no-install-recommends -y wget;\
 wget -O - http://debmon.org/debmon/repo.key | apt-key add -;\
 apt-get update;\
 apt-get -y upgrade && \
 rm -rf /var/lib/apt/lists/

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
RUN apt-get update && apt-get install -y -t wheezy-backports-sloppy icinga2-classicui icinga2;\
# nagios plugins from debian
 apt-get install -y -t wheezy-backports nagios-plugins-basic;\
 apt-get install -y -t wheezy-backports --no-install-recommends nagios-plugins-standard nagios-snmp-plugins nagios-plugins-contrib;\
# install dependencies for nagios-plugins-standard
 apt-get install -y -t wheezy-backports --no-install-recommends  dnsutils snmp libmysqlclient18;\
# install dependencies for nagios-snmp-plugins
 apt-get install -y -t wheezy-backports --no-install-recommends netbase;\
# install dependencies for nagios-plugins-contrib
 apt-get install -y -t wheezy-backports --no-install-recommends libnagios-plugin-perl liblwp-useragent-determined-perl;\
# (unofficial) monitoring-plugins-cyconet
 echo "deb     http://ftp.cyconet.org/debian restricted     main non-free contrib" > /etc/apt/sources.list.d/restricted-cyconet.list;\
 apt-get update;\
 apt-get install -y --force-yes --no-install-recommends monitoring-plugins-cyconet  && \
 rm -rf /var/lib/apt/lists/

# start init script to get environment initialised
RUN /etc/init.d/icinga2 start && /etc/init.d/icinga2 stop && \
 # set permissions to enable command pipe
 dpkg-statoverride --update --add nagios www-data 2710 /var/run/icinga2/cmd/icinga2.cmd && \
 # enable icinga feature
 icinga2 feature enable perfdata syslog && \
 # use localhost as hostname for local node
 sed -i "s#//const NodeName#const NodeName#" /etc/icinga2/constants.conf

# Copy in supervisor config files
ADD supervisord/ /etc/supervisor/conf.d/

# start supervisord to maintain system services
CMD ["/usr/bin/supervisord"]

# maybe looking into www.monitoring-portal.org/wbb/index.php?page=Thread&postID=205604#post205604 for trying icinga-web2
