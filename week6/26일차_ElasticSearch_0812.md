# # KPT 회고
1. Keep
   - ELK 정말 재밌다!
   - ELK에서 Nested,    search 2를 하게되면, Value값이 [1,2,3] 이든 ‘123’이든 상관없이 찾아진다. 기억하자
   
2. Problem
   - 적응하느라 백준 문제를 풀지 못했음
   - ELK, Nested 형식 생성은 Mapping이고, 생성은 그냥 키-value로 집어넣으면 된다.
   - 자꾸 ELK JSON 형식을 이상하게 넣는 중
     - name = “신짱구” 이런 형식으로 넣는다…
     - name : “신짱구”
     
3. Try
   - 백준은 집가서 개인적으로 하자
   - 파이썬에서 라이브러리 쓰면 쉽게 쓰겠지만, 어느정도 JavaScript 느낌으로 알아야 하지 않을까

---

# ssh <주소> -p <포트>


# SCP(sFTP)
```shell
scp -P 24 history0812.txt root@127.0.0.1:/root/scp_test
```

# ELK
- **오픈소스 검색엔진 (무료)**
  * 7버전 이하는 완전 무료였고, 현재는 돈을 내면 쓸 수 있는 기능들이 더 생김
- 인덱스에서 관리
  - 로그스태쉬 수집, Kibana 시각화
| **엘라스틱서치** | **MYSQL 등의 관계형 데이터베이스(RDBMS)** |
|:-:|:-:|
| 인덱스 | 데이터베이스 |
| 샤드 | 파티션 |
| 타입 | 테이블 |
| 문서 | 행 |
| 필드 | 열 |
| 매핑 | 스키마 |
| Query DSL | SQL |
- 엘라스틱서치에서는 하나의 인덱스에 하나의 타입만을 구성
- 기본적으로 HTTP를 통해 JSON 형식의 RESTful API를 사용
# ELK 역색인
- 키워드를 통해 문서를 찾는 방식
- ELK에서는 데이터를 저장하는 순간 모든 데이터가 인덱스가 됨
# 엘라스틱서치의 단점
* **1) 실시간 X (준실시간 검색, Near-time search)**
  * 엘라스틱서치는 데이터 저장 시점에 해당 데이터를 색인. 색인된 데이터는 1초 뒤에 검색이 가능해져서 실시간으로 검색이 불가능. 또한 내부적으로 커밋(commit), 플러쉬(flush)와 같은 복잡한 과정을 거칩니다.
* **2) 트랜잭션과 롤백 기능 X**
  * 전체적인 클러스터의 성능 향상을 위해 비용 소모가 큰 롤백과 트랜잭션 기능 X

# ELK yml
- elasticsearch.yml 파일 설정
- jvm,options -> Xms, Xmx 메모리 설정

<img width="1377" alt="image" src="https://github.com/user-attachments/assets/90c0159b-fdca-4465-bd39-8ecc533c4039">

# ELK Chrome 확장프로그램
ELK search Tool
<img width="1266" alt="image" src="https://github.com/user-attachments/assets/8699404b-e9dc-4ebf-a418-413567f743d8">

# ELK Devlopment tool
<img width="720" alt="image" src="https://github.com/user-attachments/assets/8617fbbc-cc71-4521-b375-2560952a7500">

# ELK POST
```json
POST /my-index/_doc/1
{
 "title" : "hello, elasticsearch!",
 "content" : "elasticsearch installaed and check query DSL"
}
```
> id를 명시하면서 난수화된 값이 아닌 id가 지정
```json
{
        "_index": "my-index",
        "_id": "1",
        "_score": 1,
        "_source": {
          "title": "hello, elasticsearch!",
          "content": "elasticsearch installaed and check query DSL"
        }
```

# ELK PATCH (x), (_update)
1. GET, POST, PUT, DELETE, HEAD
2. PATCH 없음
```json
PATCH my-index/_doc/1
{
  "title" : "hello, 엘라스틱서치"
}
####
{
  "error": "Incorrect HTTP method for uri [/my-index/_doc/1?pretty=true] and method [PATCH], allowed: [GET, POST, PUT, DELETE, HEAD]",
  "status": 405
}
```
3. _update 활용
```json
POST my-index/_update/1
{
  "doc" : {
            "title" : "hello, 엘라스틱서치"
          }
}
```


# ELK POST, PUT
1. 쉽게말하면 PUT은 PATCH
2. POST는 전체를 갈아끼운다.
#  ELK DELETE
```json
DELETE my-index/_doc/1

{
  "_index": "my-index",
  "_id": "1",
  "_version": 3,
  "result": "deleted",
  "_shards": {
    "total": 2,
    "successful": 1,
    "failed": 0
  },
  "_seq_no": 4,
  "_primary_term": 1
}
```

# ELK search score
```json
POST /my-index/_doc/1
{
  "title" : "hello",
  "content" : "hello"
}

POST /my-index/_doc/2
{
  "title" : "hello world",
  "content" : "hello"
}

POST /my-index/_doc/3
{
  "title" : "hello world hello",
  "content" : "hello"
}

POST /my-index/_doc/4
{
  "title" : "hello world world world",
  "content" : "hello"
}

GET /my-index/_search?q="hello"
```
> 결과는 아래와 같음
> 1. 문장의 길이에 따라 score가 낮아지고 있음.
> 2. 완벽히 hello만 있어도 1과 같이 딱 떨어지지 않음

```json
{
  "took": 4,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 4,
      "relation": "eq"
    },
    "max_score": 1.0296195,
    "hits": [
      {
        "_index": "my-index",
        "_id": "1",
        "_score": 1.0296195,
        "_source": {
          "title": "hello",
          "content": "hello"
        }
      },
      {
        "_index": "my-index",
        "_id": "3",
        "_score": 0.091951765,
        "_source": {
          "title": "hello world hello",
          "content": "hello"
        }
      },
      {
        "_index": "my-index",
        "_id": "2",
        "_score": 0.076515816,
        "_source": {
          "title": "hello world",
          "content": "hello"
        }
      },
      {
        "_index": "my-index",
        "_id": "4",
        "_score": 0.074107975,
        "_source": {
          "title": "hello world world world",
          "content": "hello"
        }
      }
    ]
  }
}
```

## BM25 알고리즘
* Elasticsearch는 기본적으로 BM25라는 검색 알고리즘을 사용합니다. 이 알고리즘도 TF-IDF를 기반으로 하지만, ***특정 필드의 길이, 빈도, 그리고 검색어가 얼마나 자주 등장하는지를 종합적으로 고려***합니다. 따라서 완전 일치하는 경우에도 다양한 요소들이 작용하여 점수가 1.0이 아닐 수 있습니다.

# ELK Nested

``` json
PUT woorifisa_nested_test
{
  "mappings": {
    "properties": {
      "student": {
        "type": "nested",
        "properties": {
          "name": {
            "type": "keyword"
          },
          "age": {
            "type": "long"
          }
        }
      }
    }
  }
}

GET woorifisa_nested_test/_search
{
  "query": {
    "nested": {
      "path": "student",
      "query": {
        "match": {
          "student.name": "신짱구"
        }
      }
    }
  }
}
```
- nested의 이런 동작 방식은 엘라스틱서치 내에서 굉장히 특수하기 때문에 nested 쿼리라는 전용 쿼리를 이용해서 검색해야 함

### 특정필드 검색 
```http
GET my_index2/_mapping

### title 필드는 keyword 자료형이라 완전 일치가 아니면 검색 안됨 
POST my_index2/_search?q=title:hello

### content 필드는 text 자료형이라 들어온 문자열을 스페이스, 품사 기준으로 끊어서 색인했기 때문에 검색됨
POST my_index2/_search?q=content:hello
```

``` javascript
POST array_test/_doc/1
{
  "longField" : 123,
  "keywordField": ["this", "is", "it"]
}


POST array_test/_doc/2
{
  "longField" :  [1, 2, 3],
  "keywordField": "this is it"
}

POST array_test/_doc/3
{
  "longField" :  [1, "2", 3],
  "keywordField":  ["this is it", 1]
}
```

> 자유롭게 찾을 수 있음, 2라는 값만 있으면 nested에서 찾아진다.

```javascript
POST /_sql?format=txt
{
  "query": "SELECT 1 + 1 AS result"
}

POST /_sql?format=json
{
  "query": "SELECT 1 + 1 AS result"
}

POST /_sql?format=txt
{
  "query": "SELECT * FROM woorifisa WHERE student.name = '신짱구'"
}
```

# ELK + SQL

<img width="1276" alt="image" src="https://github.com/user-attachments/assets/e3158b3d-2867-4071-83f9-335b88c3f2e8">
