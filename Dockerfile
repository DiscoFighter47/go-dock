# builder image
FROM golang:latest AS builder

# copy source code
WORKDIR /go/src/github.com/DiscoFighter47/go-dock
COPY . .

# login to private repository
ARG SSH_PRIVATE_KEY
RUN ./login.sh

# fetch dependencies
RUN go get -v -t -d ./...

# build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARC=amd64 go build -a -installsuffix cgo -o app


# base image
FROM alpine:latest

# Security related package
RUN apk --no-cache add ca-certificates

# copy the binary
COPY --from=builder /go/src/github.com/DiscoFighter47/go-dock/app .

# run the binary
ENTRYPOINT [ "./app" ]