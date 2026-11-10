FROM registry.access.redhat.com/ubi9/go-toolset:1.26.10-1794208260@sha256:0e3894cea4fc077084245e8aa2befc8a7d91a4f60fbf850f0b5b555cbe62ee26 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.8-1794186349@sha256:f26ef64172ea61f5ac5ba4be8c5c738bf8760b22b3e5148ce7b40f7308ab32db
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
