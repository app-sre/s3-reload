FROM registry.access.redhat.com/ubi9/go-toolset:1.26.7-1790174511@sha256:0a4666f7a4eb0644c97a73cba198eb268691b270d97831822689e7a2088f87be AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.8-1790754119@sha256:1d7c5517a4a1a8e2688620b39ee980e82505ca1ab7ae5541b5463120ae9b3897
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
