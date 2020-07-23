# news-crawler

다양한 뉴스 콘텐츠를 크롤링 하기 위한 프로젝트 이다. 크롤링한 데이터는 비상업적 영역에서 다양한 목적으로 사용할 예정이다.
또한 다양한 대상에 대해 제대로 작동하고 필요한 데이터를 모두 수집할 수 있는 크롤러를 구현한다.

# Version

`v0.0.1`

# Environments

## Build Docker Image 

```shell script
docker build -t news-crawler:0.0.1 .
```

## Run Docker Image 

```shell script
docker run -d -p 5000:5000 --name news-crawler news-crawler:0.0.1
```

## Checking Docker Log

```shell script
docker logs -f news-crawler
```

# 크롤링 대상

- 동아사이언스 [http://dongascience.donga.com/news.php?category=002]