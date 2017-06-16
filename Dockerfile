# Donot use this Dockerfile.This is not ready yet.

# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang


# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/jieniu/statusok
ADD cli /go/src/github.com/codegangsta/cli
RUN go install github.com/codegangsta/cli
ADD influxdb /go/src/github.com/influxdata/influxdb
RUN go install github.com/influxdata/influxdb
ADD errors /go/src/github.com/pkg/errors
ADD mailgun-go /go/src/github.com/mailgun/mailgun-go
RUN go install github.com/mailgun/mailgun-go
ADD logrus /go/src/github.com/Sirupsen/logrus/
RUN go install github.com/Sirupsen/logrus/

# Build the outyet command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN go install github.com/jieniu/statusok

#how to connect to localhost inside ?? http://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach

VOLUME ["/go/src/github.com/jieniu/statusok/conf/"]

ENTRYPOINT /go/bin/statusok --config /go/src/github.com/jieniu/statusok/conf/config.json

# Document that the service listens 
