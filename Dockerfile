from jpodeszwik/rpi-golang

RUN apt-get install -y git

RUN go get -u github.com/gogits/gogs && \
  cd /go/src/github.com/gogits/gogs && \
  go build

CMD /go/src/github.com/gogits/gogs/gogs web

