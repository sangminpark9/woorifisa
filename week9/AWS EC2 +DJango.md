# 43일차
---
기술세미나도 우승하고, 바쁘게 살았던 것 같다.
오랜만의 일일 공부 기록

# Django 프로젝트 aws ec2 서버로 올리기
1. Dokcer 이미지 생성
```
docker build -t renopark/django-project:v1 .
```

2. 로컬에서 실행 및 확인
```
docker run -d -p 8000:8000 renopark/django-project:v1
```

3. aws, ec2생성
   - sg, 인바운드 규칙에 tcp8000포트랑  ssh 접속 허용을 바꿔주자
4. EC2에서 Docker 이미지 실행: EC2 인스턴스에 SSH로 접속한 후
```
sudo apt update
sudo apt install docker.io -y
sudo docker pull renopark/django-project:v1
sudo docker run -d -p 8000:8000 renopark/django-project:v1
```
5. 접속
```
http://<EC2-퍼블릭-IP>:8000으로 접속
```

