FROM quay.io/app-sre/golang:1.13.1 AS builder
WORKDIR /src
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o out/s3-reload s3-reload.go

FROM quay.io/app-sre/alpine:3.8
RUN apk --no-cache add ca-certificates
USER 65534
COPY --from=builder /src/out/s3-reload /s3-reload
ENTRYPOINT ["/s3-reload"]
