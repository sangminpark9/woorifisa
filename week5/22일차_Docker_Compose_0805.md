#  # KPT 회고
1. Keep
   - 조만간 백준 골드다!
2. Problem
   - 숨바꼭질 문제를 푸는데, 다양한 테스트케이스에서 틀리고 있음. 어떻게 해결해야할까…
3. Try
   - 결국 교육이 끝나는 시간 15분 전에 문제를 풀긴했다.

---

# Docker Hub, Tag
1. Docker repository 관리를 통해 Image 생성 가능

```shell
docker build -t myuser/myapp:latest .
docker push <username>/<repository-name>:<tag>
docker push myuser/myapp:latest
```

- **태그 관리:** 여러 버전의 이미지를 관리할 때는 태그를 사용하여 각 버전을 명확히 구분하는 것이 좋습니다. 예를 들어, v1.0, v1.1과 같은 형식을 사용할 수 있음.

# Docker File 활용
- FROM [image]
- RUN [코드 명령어]
- RUN [~~~]
1. 위 구문으로 Docker 파일을 만들어 실행하면 알아서 파일이 도커 컨테이너를 만들어줌
```shell
FROM nginx:latest
COPY . .
RUN cp /index.html /usr/share/nginx/html
RUN cp /view.html /usr/share/nginx/html
RUN cp /jjangu.png /usr/share/nginx/html
```
> shell로 코드 구문을 감쌋지만,  위 코드는 docker file에 작성할 내용이다.

# Docker ignore
1. git의 ignore과 비슷하다,
2. 동작은 비슷하지만, Docker ignore은 이미지의 용량을 줄여주는데 용이.
3. 불필요한 파일이 이미지에 포함되지 않도록 하여 보안을 강화하고 빌드 시간을 줄이는 데 유용
# Docker Image 잘 만드는 법

1. 속도/용량/코드가 짧거나/cost
2. best practice 검색하여 Image를 만들자

# Docker Best Practice
- 하나의 예시로 jdk와 jre가 있다.
  - Jre는 실행만, jdk는 전체

# MyWordPress
1. 입력을 바로 mysql에 넣을 수 있도록
```shell
docker run --name my_mysql_container --network my_wordpress_network -v mysql_data:/var/lib/mysql -e
```
> network 생성

```shell
docker run --name my_mysql_container -d --net=my_wordpress_network \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=my_wordpress_db \
  -e MYSQL_USER=my_db_user \
  -e MYSQL_PASSWORD=my_db_password \
  mysql --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```
> mysql container 생성

## Docker Compose
1. 시스템 구축과 관련된 명령어를 하나의 YAML 파일에 기재해 명령어 하나로 시스템 전체를 실행, 종료, 관리할 수 있게 도와주는 도구
2. yaml에 compose-up 진행

## compose안에 sql이 같이 동작되니, 입력이 바로 sql로 들어가게 됨.
# 백준 13549 숨바꼭질3
[숨바꼭질 3](https://www.acmicpc.net/problem/13549)
```python
import sys
from collections import deque


n, m = map(int, sys.stdin.readline().rstrip().split())


visisted = set()

def bfs(n):
    q = deque()
    q.append((n,0))
    output = []
    while q:
        for _ in range(len(q)):
            N, cnt = q.popleft()
            visisted.add(N)
            
            if N == m:
                output.append(cnt)
                               
            if 0 <= N + 1 <= 100000 and N + 1 not in visisted:
                q.append((N+1, cnt+1))
                
            if 0 <= N - 1 <= 100000 and N - 1 not in visisted:
                q.append((N-1, cnt+1))
                
            if 0 <= N * 2 <= 100000 and N * 2 not in visisted:
                q.append((N*2, cnt))
    
    return min(output)
                
cnt = bfs(n)
print(cnt)
```

> 어제 푼 숨바꼭질에서 기능이 추가된 문제다.
> 이 문제는 n * 2 로 순간이동을 하면 cnt가 증가하지 않도록 해야하는데, 코드에서 튜플 형태로 cnt를 직접 가지고 가서 자기 자식들도 Cnt를 공유할 수 있도록 코드를 작성
> 1. 문제점
>    - n==M을 도착하면 최소거리가 보장되는 BFS인데, Cnt를 따로 컨트롤하다보니 최단거리가 아니게 됨.
>    - n==m이 되는 Cnt 값으로 받게

# 백준 13913 숨바꼭질4
[숨바꼭질 4 13913](https://www.acmicpc.net/problem/13913)

```python
import sys
from collections import deque

class Node:
    def __init__(self, data):
        self.next = None
        self.data = data

n, m = map(int, sys.stdin.readline().rstrip().split())


visisted = set()

def bfs(n):
    q = deque()
    
    new_node = Node(n)
    
    q.append(new_node)

    cnt = 0
    
    while q:
        for _ in range(len(q)):
            node = q.popleft()
            visisted.add(node.data)
            
            if node.data == m:
                return (cnt,node)
            
            next_node_data = [node.data * 2, node.data + 1, node.data -1]
            
            for next_data in next_node_data:
                if next_data <= 100000 and next_data not in visisted:       
                    new_node = Node(next_data)
                    new_node.next = node
                    q.append(new_node)
                    
        cnt += 1
        
                
cnt,node = bfs(n)

output = []

while node:
    output.append(node.data)
    node = node.next

output = output[::-1]
    
print(cnt)
for ele in output:
    print(ele, end = ' ')
```
> N값이 n+1, n-1, n*2, 3개의 값으로 증가하여 m값이 되는 최소값을 구하는 코드에서 지나온 N값을 노드로 연결하여 구현하였다.
> 숨바꼭질1~3까지는 next N값을 if문으로 받았지만, 같은 코드를 계속 쓰는 것 같아서 for 반복문으로 변경을 해주었고 node의 next를 추가해주었다. 마지막은 노드의 순서는 반대로 돼 있어, 리스트에 data값만 추가하여 [::-1]로 정순서로 바꿔줌

# 백준 17071 숨바꼭질5
[숨바꼭질5](https://www.acmicpc.net/problem/17071)
```python
from collections import deque

n, m = map(int, input().rstrip().split())

def bfs(n, m):
    LIMIT = 500000
    visited = [[-1, -1] for _ in range(LIMIT + 1)]  # 방문 시간 기록: [짝수 초, 홀수 초]
    
    q = deque()
    q.append(n)
    visited[n][0] = 0  # 시작 위치 방문 시간 기록 (짝수 초)

    time = 0
    
    while q:
        size = len(q)
        
        for _ in range(size):
            N = q.popleft()
            
            # 동생의 현재 위치와 비교
            if N == m:
                return time

            # 다음 이동 가능한 위치들
            next_N_list = [N + 1, N - 1, N * 2]
            
            for next_N in next_N_list:
                if 0 <= next_N <= LIMIT and visited[next_N][(time + 1) % 2] == -1:
                    visited[next_N][(time + 1) % 2] = time + 1
                    q.append(next_N)
        
        time += 1
        m += time  # 동생의 위치 갱신
        
        if m > LIMIT:
            return -1
        
        # 현재 시간에 동생의 위치에 수빈이가 도달한 적이 있는지 확인
        if visited[m][time % 2] != -1:
            return time

    return -1

print(bfs(n, m))
```

> 간단히 생각하자면 수빈이가 지나친 적이 있는 m값이 홀수 초에 도착했다면, 수빈이가 도착한 적이 있는 m값도 홀수 초에 도착해야 만날 수 있다는 소리다.
> 만약 다르다면 못 만난다고 가정이 되는 것.
```python
if visited[m][time % 2] != -1:
	return time
```
> 위 코드를 통해서 n값이 진행한 초를 홀수, 짝수로 판별해서 입력하고
> time은 동생이 도착한 time의 홀짝
