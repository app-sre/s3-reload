FROM registry.access.redhat.com/ubi9/go-toolset:9.6-1753853351@sha256:3ce6311380d5180599a3016031a9112542d43715244816d1d0eabc937952667b AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.6-1753762263@sha256:67fee1a132e8e326434214b3c7ce90b2500b2ad02c9790cc61581feb58d281d5
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
