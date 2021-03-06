#!/bin/bash
TEMPSCRIPT=/tmp/testssl.sh
RESULTDIR=/srv/testssl
HOSTCONFIG=/etc/testssl.conf

# removing old script
rm -rf ${TEMPSCRIPT};\
# generating test script
echo "RESULTDIR=${RESULTDIR}" >> ${TEMPSCRIPT}
echo '[ "$(/usr/bin/tty || true)" != "not a tty" ] && DOCKER_RUN_OPTS="-i"' >> ${TEMPSCRIPT}
for I in $(cat ${HOSTCONFIG}); do \
 echo $I| awk -F':' '{printf "docker run --rm -t ${DOCKER_RUN_OPTS} waja/testssl.sh --starttls %s %s:%s | grep -v ':/usr/bin/openssl' | grep -v 'built:' | grep -v #Testing now# | grep -v #Done now# > ${RESULTDIR}/%s_%s\n",$3,$1,$2,$1,$2}'>> ${TEMPSCRIPT}; \
done && \
# Fixing our (intensionally) broken script
sed -i "s/#/'/g" ${TEMPSCRIPT}
# running test script
sh ${TEMPSCRIPT}
# commiting the (new) results with propper timestamp
cd ${RESULTDIR} && git add -A && git commit -am "Changes from $(date +%s)"
