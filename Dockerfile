FROM golang:alpine as build
WORKDIR /src
ADD main.go .
RUN go build -o helloserver -ldflags="-s -w"

FROM alpine:edge
LABEL maintainer "Ramon van Stijn <ramons@nl.ibm.com>"
RUN addgroup -g 1970 hello \
    && adduser -u 1970 -G hello -s /bin/sh -D hello
COPY --chown=hello:hello --from=build /src/helloserver /app/helloserver
USER hello
EXPOSE 1970
ENTRYPOINT /app/helloserver
