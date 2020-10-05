FROM registry.access.redhat.com/ubi8/go-toolset:1.13.15 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.2
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
