FROM alpine:3.8

RUN apk --no-cache add ca-certificates

USER 65534

ARG BINARY=s3-reload
COPY out/$BINARY /s3-reload

ENTRYPOINT ["/s3-reload"]
