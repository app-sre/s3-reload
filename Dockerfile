FROM registry.access.redhat.com/ubi9/go-toolset:1.24.4-1754467841@sha256:3f552f246b4bd5bdfb4da0812085d381d00d3625769baecaed58c2667d344e5c AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.6-1754456323@sha256:e6b39b0a2cd88c0d904552eee0dca461bc74fe86fda3648ca4f8150913c79d0f
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
