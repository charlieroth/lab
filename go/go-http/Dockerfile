FROM golang:latest

WORKDIR /go-http

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -v -o main .

EXPOSE 3000:3000

CMD ["./main"]
