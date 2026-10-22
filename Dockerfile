FROM registry.access.redhat.com/ubi9/go-toolset:1.26.10-1792592174@sha256:d4d25f236c2b3cd27eb407e3b3478bef0b75d644ee6d11772217f537be926b11 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.8-1791898448@sha256:c4c285d42941ebb2bd4da878479008e1e4536bb599aad1dbe568f89de9053661
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
