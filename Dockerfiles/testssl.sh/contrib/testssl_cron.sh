#!/bin/bash
TEMPSCRIPT=/tmp/testssl.sh
RESULTDIR=/srv/testssl

# removing old script
rm -rf ${TEMPSCRIPT};\
# generating test script
echo "RESULTDIR=${RESULTDIR}" >> ${TEMPSCRIPT}
for I in $(cat /etc/testssl.conf); do \
 echo $I| awk -F':' '{printf "docker run --rm -it waja/testssl.sh --starttls %s %s:%s | grep -v ':/usr/bin/openssl' | grep -v 'built:' | grep -v #Testing now# | grep -v #Done now# > ${RESULTDIR}/%s_%s\n",$3,$1,$2,$1,$2}'>> ${TEMPSCRIPT}; \
done && \
# Fixing our (intensionally) broken script
sed -i "s/#/'/g" ${TEMPSCRIPT}
# running test script
sh ${TEMPSCRIPT}
# commiting the (new) results with propper timestamp
cd ${RESULTDIR} && git add -A && git commit -am "Changes from $(date +%s)"
