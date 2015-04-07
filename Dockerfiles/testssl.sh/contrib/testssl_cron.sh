#!/bin/bash

# generating test script and running tests
rm -rf /tmp/testssl.sh;\
for I in $(cat /etc/testssl.conf); do \
 echo $I| awk -F':' '{printf "docker run --rm -it waja/testssl.sh --starttls %s %s:%s | grep -v ':/usr/bin/openssl' | grep -v 'built:' | grep -v #Testing now# | grep -v #Done now# > /srv/testssl/%s_%s\n",$3,$1,$2,$1,$2}'>> /tmp/testssl.sh; \
done && \
sed -i "s/#/'/g" /tmp/testssl.sh
sh /tmp/testssl.sh
cd /srv/testssl && git add -A && git commit -am "Changes from $(date +%s)"
