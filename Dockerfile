FROM registry.access.redhat.com/ubi9/go-toolset:1.24.4-1754384957@sha256:198ee8c19c6b152a94a4c58952151c59efa0207f4f39c05c8b3e8a97b2ed5c0d AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.6-1754356396@sha256:295f920819a6d05551a1ed50a6c71cb39416a362df12fa0cd149bc8babafccff
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
