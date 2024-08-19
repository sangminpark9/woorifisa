# KPT 회고
1. Keep
   - 기술 세미나를 일찍일찍 준비한다는점?
2. Problem
   - 기술세미나 하느라 코딩문제 풀거나 개인적인 공부가 아쉽다
3. Try
   - 잠을 줄여야하나
---

# ELK match_phrase, Slop
1. Slop이라는 파라미터로 단어의 순서는 유지하되 중간에 몇 개의 토큰을 봐줄 수 있는지 결정할 수 있음

```javascript
GET my_index/_search
{
  "query": {
    "match_phrase": {
      "title" : {
        "query": "hello hello",
        "slop" : 2
      }
    }
 }
}
```

# Bool query
1. must : 꼭 포함
2. must_not : 절대 불포함
3. should : 해당 조건이 있으면 검색 결과에 가산점
4. filter :  조건을 추가하되, 점수에는 불포함
# noSQL 특징
1. SQL과 달리 테이블명, where절을 유연하게 사용 가능
```javascript
# ELK에서는 test, my_bulk 2개의 테이블을 조회한다고 1줄로 명시 가능
GET test,my_bulk/_search
```

# 실습
1. test 인덱스에서 나이가 34살이면서 Firstname이 dillard
```javascript
# 나이가 34살이면서 firstname이 dillard
POST test/_search
{
  "query": {
    "bool": {
      "must": [
        {"match": {
          "age": 34
          }
        },
        {"match":{
          "firstname": "dillard"
          }
        }
      ]
    }
  }
}
```
> bool의 must는 리스트 형식이구나

# ELK, bool, must, range
1. gte, lte, gt, lt 사용
```javascript
# 나이가 34살이면서 firstname이 dillard
POST test/_search
{
  "query": {
    "bool": {
      "must": [
        {"range": {
          "balance": {
            "gt": 16418
          }
        }
        }
      ]
    }
  }
}
```

# 실습2
1. BalanceRk 3000보다 많으면서 Dillard가 아닌 사람
```javascript
POST test/_search
{
  "query": {
    "bool": {
      "must": [
        {"range": {
          "balance": {
            "gt": 3000
          }
          }
        }
      ],
      "must_not": [
        {
          "match": {
            "firstname": "Dillard"
          }
        }
      ]
    }
  }
}
```
> query -> bool -> must, must_not, should -> match, range 등

# 실습3
```javascript
# 실습. test에서 수행
# 0-1. D로 firstname이 시작하는 사람
POST test/_search
{
  "query": {
    "query_string": {
      "default_field": "firstname",
      "query": "D*"
    }
  }
}

# 0-2. D로 firstname이 시작하는 4글자의 사람
POST test/_search
{
  "query": {
    "query_string": {
      "default_field": "firstname",
      "query": "D???"
    }
  }
}

# 0-3. firstname 혹은 lastname(fields)이 D 어쩌고인 사람
# 0-3-1
POST test/_search
{
  "query": {
    "query_string": {
      "fields": ["firstname", "lastname"],
      "query": "D*"
    }
  }
}

# 0-3-2
POST test/_search
{
  "query": {
    "query_string": {
      "default_field": "firstname",
      "query": "firstname:D* or lastname:D*"
    }
  }
}

# 실습. my_bulk 에서 수행

# 1. google 이라는 단어가 들어간 모든 문서를 검색해보세요
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "google"
          }
        }
      ]
    }
  }
}

# match는 소문자 대문자 안가리고 검색을 해줍니다 
# 띄어쓰기가 OR로 취급됩니다

# 2. Chrome Google이 순서대로 들어있는 문서를 검색
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "message": "Chrome Google"
          }
        }
      ]
    }
  }
}

# 3. pink가 들어가되 blue가 같이 들어있는 경우 가중치 부여 (blue가 없는 경우는 후순위로 검색)
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "pink"
          }
        }
      ],
      "should": [
        {
          "match": {
            "message": "blue"
          }
        }
      ]
    }
  }
}


# 4. pink가 들어가되 blue가 같이 들어있는 경우 SCORE는 바뀌지 않되 해당 조건을 검색
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "pink"
          }
        }
      ],
      "filter": [
        {
          "match": {
            "message": "blue"
          }
        }
      ]
    }
  }
}
POST my_bulk/_search

# 5. "하늘사"라는 단어가 있거나 없거나 상관 없이 google, chrome이 들어간 경우 검색
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "google chrome"
          }
        }
      ]
    }
  }
}
POST my_bulk/_search

# 6. 하늘사는 안들어가고 chrome은 들어가는 다큐먼트를 검색
# 6-1. 하늘사가 없어서 점수를 부여하고 싶으면 bool 
POST my_bulk/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "message": "chrome"
          }
        }
      ],
      "must_not": [
        {
          "match": {
            "message": "하늘사"
          }
        }
      ]
    }
  }
}
```

# ELK 토크나이저
<img width="580" alt="image" src="https://github.com/user-attachments/assets/a01c63cd-9c39-49ee-b120-c6869ef0d87f">

```javascript
# html strip 캐릭터필드 적용
POST _analyze
{
  "char_filter": ["html_strip"],
  "text": "<p>I&apos;m so <b>happy</b>!</p>"
}
```

```javascript
  "tokenizer": {
    "type": "ngram",
    "min_gram": 3,
    "max_gram": 4
##
# "o, W"나 ", Wo"나 "ld!"처럼 공백 문자나 문장 부호가 포함되어 사실상 의미가 없는 토큰도 포함되는데... 
# token_chars라는 속성을 사용한다면?
    "token_chars": ["letter"]
# edge_ngram
# 모든 토큰의 시작 글자를 단어의 시작 글자로 고정시켜서 생성 
# - llo 같은 토큰은 생성되지 않음
    "type": "edge_ngram",
```

# character filed -> tokenizer -> option
# 애널라이저란? 위와 같다.

```javascript
POST _analyze
{
  "char_filter": ["html_strip"],
  "tokenizer": {
    "type": "edge_ngram",
    "min_gram": 3,
    "max_gram": 4,
    "token_chars": ["letter"]
  },
  "filter" : ["lowercase"],
  "text": "<p>I&apos;m so <b>happy<b/></p>"
}
# 최종
# char_filter -> tokenizer -> filter
```

# 형태소 분석
```shell
bin/elasticsearch-plugin install analysis-nori   
bin/elasticsearch-plugin install analysis-kuromoji
bin/elasticsearch-plugin install analysis-smartcn
```

```javascript
get /_analyze
{
  "tokenizer" : "nori_tokenizer",
  "text" : "아이고 두시 반 밥먹어서, 졸려요!!!! "
}
```
