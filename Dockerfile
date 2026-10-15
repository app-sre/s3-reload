FROM registry.access.redhat.com/ubi9/go-toolset:1.26.7-1792010711@sha256:60fd6fb2998c40ad0d6561c34e83588b986a0cf7771f64e5e5c295ba87101f9b AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go

FROM registry.access.redhat.com/ubi9-minimal:9.8-1791898448@sha256:c4c285d42941ebb2bd4da878479008e1e4536bb599aad1dbe568f89de9053661
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
LABEL konflux.additional-tags="1.0.0"
ENTRYPOINT ["/s3-reload"]
