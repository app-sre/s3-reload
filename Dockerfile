FROM registry.access.redhat.com/ubi9/go-toolset:1.24.6-1756993846@sha256:14c369670cf3473d8e9b93e42d120c01b79a6f13884c396a1c89b7ca46f859b7 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.6-1755695350@sha256:2f06ae0e6d3d9c4f610d32c480338eef474867f435d8d28625f2985e8acde6e8
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
