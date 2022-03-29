all:
	make docker-build && docker-compose up

docker-build:
	docker build -t go-http-app .

docker-run:
	docker run -d -p 3000:3000 --name=go-http-app go-http-app
