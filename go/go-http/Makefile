run:
	go run main.go

build:
	go build main.go

db:
	docker build -t go-http-app .

dr:
	docker run -d -p 3000:3000 --env-file .env --name=go-http-app go-http-app
