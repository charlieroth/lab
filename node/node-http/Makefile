all:
	make docker-build-a && make docker-build-b && docker-compose up

docker-build-a:
	docker build -f Dockerfile.service-a -t node-http-service-a ./services-a

docker-build-b:
	docker build -f Dockerfile.service-b -t node-http-service-b ./services-b

docker-run-a:
	docker run -d --name=node-http-service-a node-http-service-a

docker-run-b:
	docker run -d --name=node-http-service-b node-http-service-b
