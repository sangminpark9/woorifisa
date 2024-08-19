# KPT 회고
1. Keep
   - 
2. Problem
   - 집중이 안되고 있음
3. Try
   - 현재 상태에서 무엇을 집중해야할지 정해야할 것

---

# Tag Cloud

# filter
<img width="1230" alt="image" src="https://github.com/user-attachments/assets/4cdf9069-473c-4074-ae82-2a2f104b9e1e">

1. customers가 1000이상인 값만 필터 가능

![image](https://github.com/user-attachments/assets/65755ac3-84ec-4f3d-b4f7-041b49ff7265)

- 개별적으로 분석해본 것

# Logstash .conf 설정
```json
input{
    file{
        path => "/Users/sangmin/Desktop/elk/test2.log"
        start_position => "beginning"
    }
}

filter {
    grok{
        match => {"message" => "%{MONTHNUM:month}월 %{MONTHDAY:day}, %{YEAR:year} %{HOUR:hour}:%{MINUTE:minute}:%{SECOND:second} (?<time>[가-힣]{2}) %{DATA:class} log"}
        match => {"message" => "정보:%{DATA:info}"}
    }
}



output{
    elasticsearch {
    hosts => ["http://127.0.0.1:9200"]
    index => "logs_multiline-%{+YYYY.MM.dd}"
      }
}
```

```text
6월 11, 2018 5:59:01 오후 org.apache.catalina.core.ApplicationContext log
정보: No Spring WebApplicationInitializer types detected on classpath
6월 11, 2018 5:59:02 오후 org.apache.catalina.core.ApplicationContext log
정보: Initializing Spring FrameworkServlet 'action'
6월 11, 2018 6:01:13 오후 org.apache.catalina.core.ApplicationContext log
정보: Destroying Spring FrameworkServlet 'action'
6월 11, 2018 6:01:25 오후 org.apache.catalina.core.ApplicationContext log
정보: No Spring WebApplicationInitializer types detected on classpath
6월 11, 2018 6:01:25 오후 org.apache.catalina.core.ApplicationContext log
정보: Initializing Spring FrameworkServlet 'action'
```
> 로그가 2줄인 경우, grack의 filter를 2줄로 입력하면 된다.
> log파일이 추가되면 logstash가 자동으로 인덱스 화를 시키게됨

```yaml
- pipeline.id: id_a
  path.config: "config/logstash-double.conf"

- pipeline.id: id_b
  path.config: "config/logstash-double2.conf"
```
> /bin/logstash 실행 conf 파일 자동 실행
