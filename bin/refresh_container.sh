#!/bin/bash

docker container stop news-crawler
docker container rm news-crawler
docker build -t news-crawler:0.0.1 .
docker run -d -p 5000:5000 --name news-crawler news-crawler:0.0.1
docker logs -f news-crawler