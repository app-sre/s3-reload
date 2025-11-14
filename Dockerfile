FROM registry.access.redhat.com/ubi9/go-toolset:1.24.6-1763038106@sha256:380d6de9bbc5a42ca13d425be99958fb397317664bb8a00e49d464e62cc8566c AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.7-1762956380@sha256:53ea1f6d835898acda5becdb3f8b1292038a480384bbcf994fc0bcf1f7e8eaf7
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
