FROM mhart/alpine-node:latest
WORKDIR /opt/jingo
RUN apk --update add --virtual build-dependencies git ca-certificates && \
  git clone https://github.com/claudioc/jingo.git /opt/jingo && cd /opt/jingo && \
  LATEST_TAG=$(git tag -l 'v*.[0-9]' --sort='v:refname'| tail -1); git checkout $LATEST_TAG -b $LATEST_TAG && \
  git config --global user.name "Jingo Wiki" && git config --global user.email "everyone@jingo" && npm install
ADD start.sh /opt/jingo/start.sh
CMD /bin/sh /opt/jingo/start.sh
