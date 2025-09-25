# build
FROM golang:1.25-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o helmtest main.go

# runtime
FROM alpine:3.19
WORKDIR /app
COPY --from=build /app/helmtest .
EXPOSE 8080
CMD ["./helm"]