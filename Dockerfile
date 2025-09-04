FROM registry.access.redhat.com/ubi9/go-toolset:1.24.6-1756913080@sha256:bacdac6f6205a52ce6cf5d7b884fbedafa4ba341ab377f5c2c62015022fdf8c7 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.6-1755695350@sha256:2f06ae0e6d3d9c4f610d32c480338eef474867f435d8d28625f2985e8acde6e8
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
