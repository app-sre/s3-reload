FROM registry.access.redhat.com/ubi9/go-toolset:1.26.5-1785791459@sha256:46376c6723c3a4961a165c2768461e7fac48a79932cdde0a6e6a57724ef61ba0 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.8-1785777232@sha256:48fa5d8cda7fc00d270d8747c3eaa54ae196f0820d8540074a9c8c61d5e3056f
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
