# KPT 회고 30일
1. Keep
   
2. Problem

3. Try

---
# 복습, Logstash pipeline

logstash의 conf 파일

```yaml
    grok{
        match => {"message" => "%{IP:client_ip} - - \[%{GREEDYDATA:timestamp}\] \"%{WORD:http_method} %{URIPATH:request_path} HTTP/%{NUMBER:http_version}\" %{NUMBER:response_code} -"}
        match => {"message" => '%{LOGLEVEL:log_level}:     %{IP:client_ip}:%{NUMBER:client_port} - "%{WORD:http_method} %{URIPATH:request_path} HTTP/%{NUMBER:http_version}" %{NUMBER:response_code} %{WORD:status_message}'}
    }

```

```yaml
    mutate {
        add_field => { "description" => "second pipeline!" }
        remove_field => ["host", "@version", "message"]
    }
```
> fileter 부분의 Grok과 같은 들여쓰기 레벨 

1. server1 -> fast api/log
2. server2 -> flask/log

# 클러스터 운영
- cat API
```json
GET _cat/health # 전반적인 클러스터의 상태 GET _cat/indices # 인덱스의 종류와 상태 조회 

GET _cat/nodes # 각 노드의 이름, 상태 조회 GET _cat/shards # 샤드의 상태 조회

GET _cat/recovery # 진행 중이거나 완료된 샤드 복구 작업 정보 조회

GET _cat/allocation # 샤드 할당에 관한 정보 조회 GET _cat/thread_pool # 각 노드의 스레드 풀 상태 조회 

GET _cat/master # 현재 마스터로 선출된 노드 확인
```

# Streamlit, logstach
