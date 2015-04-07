#!/bin/bash
TEMPSCRIPT=/tmp/testssl.sh

# generating test script and running tests
rm -rf ${TEMPSCRIPT};\
for I in $(cat /etc/testssl.conf); do \
 echo $I| awk -F':' '{printf "docker run --rm -it waja/testssl.sh --starttls %s %s:%s | grep -v ':/usr/bin/openssl' | grep -v 'built:' | grep -v #Testing now# | grep -v #Done now# > /srv/testssl/%s_%s\n",$3,$1,$2,$1,$2}'>> ${TEMPSCRIPT}; \
done && \
sed -i "s/#/'/g" ${TEMPSCRIPT}
sh ${TEMPSCRIPT}
cd /srv/testssl && git add -A && git commit -am "Changes from $(date +%s)"
