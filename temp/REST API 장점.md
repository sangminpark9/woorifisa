# REST API 장점 목차
1. 단순성과 사용 용이성
2. 확장성
3. 언어 및 플랫폼 독립성
4. 캐싱 지원
5. 상태 비저장성
6. 보안성

# 장점 1. 단순성과 사용 용이성:

>REST API는 HTTP 표준을 기반으로 하기 때문에 이해하고 사용하기 쉽습니다. 웹 개발자에게 친숙한 GET, POST, PUT, DELETE 등의 HTTP 메서드를 사용합니다.

<img width="763" alt="image" src="https://github.com/user-attachments/assets/23dd524e-677b-4405-85ea-e6142c68b329">
[출처 : https://velog.io/@dataliteracy/HTTP-%EB%A9%94%EC%84%9C%EB%93%9C-%EB%8F%99%EC%9E%91%ED%95%B4%EB%B3%B4%EA%B8%B0]


# 장점 2. 확장성:

> REST는 클라이언트와 서버 간의 상호 작용을 느슨하게 결합하기 때문에, 시스템을 확장하거나 변경할 때 유연성을 제공합니다. 서버 측의 변경이 클라이언트 측에 큰 영향을 미치지 않습니다.

# 장점 3.언어 및 플랫폼 독립성:

> REST API는 JSON, XML, HTML 등 다양한 형식을 사용하여 데이터를 교환할 수 있으며, 클라이언트와 서버는 서로 다른 언어와 플랫폼을 사용할 수 있습니다.

### 영화 정보를 요청할 때
1. HTTP 패킷, JOSN 예시

```vbnet
GET /api/movies/1 HTTP/1.1
Host: example.com
Accept: application/json
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "title": "Inception",
  "rating": 9.0,
  "release_date": "2010-07-16",
  "director": "Christopher Nolan",
  "actors": ["Leonardo DiCaprio", "Joseph Gordon-Levitt"]
}
```

2. HTTP 패킷, XML 예시

```vbnet
GET /api/movies/1 HTTP/1.1
Host: example.com
Accept: application/xml
```

```http
HTTP/1.1 200 OK
Content-Type: application/xml

<movie>
  <id>1</id>
  <title>Inception</title>
  <rating>9.0</rating>
  <release_date>2010-07-16</release_date>
  <director>Christopher Nolan</director>
  <actors>
    <actor>Leonardo DiCaprio</actor>
    <actor>Joseph Gordon-Levitt</actor>
  </actors>
</movie>
```
3. HTTP 패킷, html 예시
```vbnet
GET /api/movies/1 HTTP/1.1
Host: example.com
Accept: text/html
```

```http
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Details</title>
</head>
<body>
    <h1>Inception</h1>
    <p><strong>Rating:</strong> 9.0</p>
    <p><strong>Release Date:</strong> July 16, 2010</p>
    <p><strong>Director:</strong> Christopher Nolan</p>
    <h2>Actors</h2>
    <ul>
        <li>Leonardo DiCaprio</li>
        <li>Joseph Gordon-Levitt</li>
    </ul>
</body>
</html>
```

# 장점 4. 캐싱 지원:

> REST API는 HTTP 프로토콜의 기본 기능인 캐싱을 지원합니다. 이를 통해 요청 결과를 캐싱하여 서버 부하를 줄이고, 응답 속도를 높일 수 있습니다.

<img width="616" alt="image" src="https://github.com/user-attachments/assets/96ddde3d-9dca-4315-a844-8fef68d89324">
[출처 : https://pwa-workshop.js.org/4-api-cache/#cache-update-refresh]

1. 예시

```python
# flask_cache 활용
@app.route('/data')
@cache.cached(timeout=10)  # 10초 동안 캐시 유지
def get_data():
    print("Fetching data...")
    data = {"value": "This is some data."}
    return jsonify(data)
```
<img width="567" alt="image-2" src="https://github.com/user-attachments/assets/5469cf66-ffad-41a3-b09b-c1954857d6f8">
![alt text](image-3.png)
<img width="425" alt="image-3" src="https://github.com/user-attachments/assets/5c3a796a-a37e-475b-aee2-4ce96b4f7d0c">


# 장점 5. 상태 비저장성:

> REST API는 상태 비저장성을 유지하여 각 요청이 독립적이며, 서버는 클라이언트의 이전 요청 상태를 기억할 필요가 없음. 이는 서버의 확장성과 성능을 향상 시킴

1. 독립적인 요청 처리: REST API는 각 요청이 독립적이기 때문에, 서버는 클라이언트의 이전 요청 상태를 기억할 필요 없음. 서버끼리의 동기화 문제 제거, 즉, 서버는 추가하면 추가한 만큼 무한대로 추가 가능, 근데 분산 처리가 어렵겠지?

2. 부하 분산이 쉬움: 모든 서버가 동일한 방식으로 요청을 처리할 수 있기 때문에, 부하 분산 장치를 사용하여 요청을 여러 서버에 쉽게 분배할 수 있음. 특정 서버에 클라이언트를 고정시킬 필요가 없으므로 서버의 추가나 제거가 용이

3. 리소스 사용 최적화: 상태를 관리하지 않기 때문에 서버는 불필요한 메모리나 저장소를 사용하지 않으며, 서버 자원의 효율적 사용을 가능하게 하고, 서버가 더 많은 클라이언트 요청을 처리하게 함

# 장점 6. 보안성:

> REST API는 HTTPS를 통해 보안 통신을 지원할 수 있으며, OAuth와 같은 인증 및 권한 부여 메커니즘을 쉽게 통합할 수 있습니다.

1. HTTPS란?
<img width="758" alt="image" src="https://github.com/user-attachments/assets/12bb55e7-04b1-4f1f-888d-a9cae9e37c55">
[출처 : https://www.thesslstore.com/blog/what-is-https-what-https-stands-for/]

![image](https://github.com/user-attachments/assets/87c6b74c-bac4-4ea8-8cdd-81f7ab9493fe)
[출처 : https://www.geeksforgeeks.org/explain-working-of-https/]

  - HTTP의 보안 버전
  - 암호화 (Encryption)
    - HTTPS는 SSL,TLS(Secure Sockets Layer,Transport Layer Security) 프로토콜을 사용하여 데이터를 암호화
  - 데이터 무결성 (Data Integrity)
    - HTTPS는 데이터가 전송되는 과정에서 변경되지 않았는지 확인하는 기능을 제공
  - 서버 인증 (Server Authentication)
    - 서버는 SSL/TLS 인증서를 통해 자신을 인증하고, 클라이언트는 이 인증서를 검증하여 서버의 신뢰성을 확인
  
2. HTTPS SSL 예시
  - Flask == 기본적으로 개발용 서버
    -SSL/TLS 인증서 설정
  ```python
  from flask import Flask

  if __name__ == "__main__":
      app.run(ssl_context=('path/to/your/certificate.crt', 'path/to/your/private.key'))
  ```
    ssl_context 인자에 인증서 파일(.crt)과 개인 키 파일(.key) 경로를 지정합니다.
    이 방법은 개발 환경이나 테스트용으로 적합하며, 실제 배포 환경에서는 Nginx 또는 Apache와 같은 리버스 프록시를 통해 SSL을 처리하는 것이 좋음
  
  - nginx 리버스 프록시
    > nginx.conf 또는 사이트별 설정 파일에서 SSL을 설정
    ```
    # SSL을 사용하여 HTTPS 트래픽을 수신하는 서버 블록
    server {
        listen 443 ssl;  # 포트 443에서 SSL을 사용하여 HTTPS 요청을 수신합니다.
        server_name example.com;  # 요청을 받을 도메인 이름입니다.

        # SSL 인증서 및 개인 키 파일 경로를 설정합니다.
        ssl_certificate /etc/ssl/certs/example.com.crt;  # 서버 인증서 파일의 경로
        ssl_certificate_key /etc/ssl/private/example.com.key;  # 서버 인증서의 개인 키 파일 경로

        # HTTPS 요청을 처리할 위치 블록
        location / {
            proxy_pass http://127.0.0.1:8000;  # Flask/Django 애플리케이션이 실행 중인 로컬 포트입니다.
            proxy_set_header Host $host;  # 클라이언트의 요청 호스트 헤더를 백엔드 서버로 전달합니다.
            proxy_set_header X-Real-IP $remote_addr;  # 클라이언트의 실제 IP 주소를 백엔드 서버로 전달합니다.
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;  # 클라이언트의 IP 주소를 X-Forwarded-For 헤더에 추가합니다.
            proxy_set_header X-Forwarded-Proto $scheme;  # 요청이 HTTPS로 전달되었음을 백엔드 서버에 알립니다.
        }
    }

    # HTTP 트래픽을 HTTPS로 리다이렉트하는 서버 블록
    server {
        listen 80;  # 포트 80에서 HTTP 요청을 수신합니다.
        server_name example.com;  # 요청을 받을 도메인 이름입니다.
        
        # 모든 HTTP 요청을 HTTPS로 리다이렉트합니다.
        return 301 https://$host$request_uri;  # 301 상태 코드로 영구 리다이렉트합니다. 요청 URI를 그대로 유지하며 HTTPS로 전환합니다.
    }

    ```
