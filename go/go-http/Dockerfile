FROM golang:latest

WORKDIR /usr/src/go-http

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download && go mod verify

# copy rest of files
COPY . .

# Builds the application as a staticly linked one, to allow it to run on alpine
RUN go build -v -o /usr/local/bin/app ./...

# Exposes port 3000 because our program listens on that port
EXPOSE 3000:3000

CMD ["app"]

