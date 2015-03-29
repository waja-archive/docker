#
# apache2 Dockerfile
#
# Pull base image (this is a stock stable image right from debootstrap)
FROM waja/debian:latest

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

#USER user
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /home/user
ENV LC_ALL C.UTF-8
WORKDIR /home/user

# Disable installation of Recommends
RUN echo 'Aptitude::Recommends-Important "False";' > /etc/apt/apt.conf.d/10norecommands && \
# create a user
 groupadd -g 1000 user && \
 useradd --create-home -d /home/user -g user -u 1000 user && \
# configure locale
 apt-get update && apt-get install --no-install-recommends locales && \
 rm -rf /var/lib/apt/lists/ && \
 dpkg-reconfigure locales && \
 locale-gen C.UTF-8 && \
 /usr/sbin/update-locale LANG=C.UTF-8 && \
# configure timezone
 echo "Europe/Prague" > /etc/timezone && \
 dpkg-reconfigure -f non-interactive tzdata	

# Install dependencies for building travis cli
RUN apt-get update && apt-get install -y signing-party msmtp-mta;\
 rm -rf /var/lib/apt/lists/ && \
# create gpg config
 mkdir -p .caff/gnupghome && \
 mkdir -p .caff/keys && \
	chmod 700 .caff/gnupghome && \
	{ \
#		echo 'force-v3-sigs'; \
#		echo 'escape-from-lines'; \
#		echo 'lock-once'; \
#		echo 'keyserver pool.sks-keyservers.net'; \
		echo 'personal-digest-preferences SHA512';  \
		echo 'cert-digest-algo SHA512'; \
		echo 'default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed'; \
		echo 'keyid-format long'; \
	} > .caff/gnupghome/gpg.conf

ENTRYPOINT ["caff"]
CMD ["-p"]
