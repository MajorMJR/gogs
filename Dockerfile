from jpodeszwik/rpi-golang

RUN \
  apt-get install -y git

# Install gogs
RUN \
  go get -tags sqlite github.com/gogits/gogs && \
  cd /go/src/github.com/gogits/gogs && \
  go build -tags sqlite

RUN useradd --shell /bin/bash --home /data/git git

ENV GOGS_CUSTOM /data

WORKDIR /data

VOLUME /data

ADD run.sh /bin/

CMD /bin/run.sh

