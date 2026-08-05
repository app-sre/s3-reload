FROM registry.access.redhat.com/ubi9/go-toolset:1.26.5-1785791459@sha256:46376c6723c3a4961a165c2768461e7fac48a79932cdde0a6e6a57724ef61ba0 AS builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go
LABEL konflux.additional-tags="1.0.0"

FROM registry.access.redhat.com/ubi9-minimal:9.8-1785906621@sha256:dd334afa72444fa46238fcf9e6bd399245adf746378735348cf84b9dfdca38f1
COPY --from=builder /opt/app-root/src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
