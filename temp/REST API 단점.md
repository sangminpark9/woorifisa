# REST API 단점 목차
1. 오버패칭과 언더패칭 문제

2. 버전 관리의 어려움

3. 복잡한 데이터 구조 처리 어려움

4. 상태 비저장성의 한계

5. 성능 문제

6. API 표준 부족

+++ 장점 : 캐시

# 단점 1.1 오버패치 예시

1. name Filed만 가져오고 싶어도, 모든 filed를 가져옴

```python
user_response = requests.get("https://api.example.com/users/1")
user_data = user_response.json()
```

```json
# Name만 필요한데, 모든 결과 값을 가져옴
{
    "id": 1,
    "username": "john_doe",
    "email": "john.doe@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "date_of_birth": "1980-01-01",
    "address": {
        "street": "1234 Elm Street",
        "city": "Springfield",
        "state": "IL",
        "zip_code": "62704",
        "country": "USA"
    },
    "phone_numbers": [
        {"type": "home", "number": "555-1234"},
        {"type": "work", "number": "555-5678"},
        {"type": "mobile", "number": "555-8765"}
    ],
    "social_media": {
        "twitter": "@johndoe",
        "facebook": "john.doe",
        "instagram": "john_doe_insta",
        "linkedin": "john-doe-123456"
    },
    "employment": {
        "company": "Doe Industries",
        "position": "Software Engineer",
        "years_of_experience": 10,
        "salary": "$100,000"
    },
    "hobbies": ["reading", "golf", "coding", "travelling"],
    "preferences": {
        "newsletter_subscribed": true,
        "preferred_language": "English",
        "preferred_currency": "USD",
        "marketing_opt_in": false
    },
    "emergency_contacts": [
        {"name": "Jane Doe", "relationship": "spouse", "phone": "555-4321"},
        {"name": "Jake Doe", "relationship": "brother", "phone": "555-8765"}
    ],
    "medical_info": {
        "blood_type": "O+",
        "allergies": ["peanuts", "shellfish"],
        "medications": ["aspirin"]
    },
    "travel_history": [
        {"country": "France", "year": 2019},
        {"country": "Japan", "year": 2018},
        {"country": "Brazil", "year": 2017}
    ],
    "financial_info": {
        "credit_score": 750,
        "bank_accounts": [
            {"bank_name": "Bank of America", "account_number": "123456789"},
            {"bank_name": "Chase", "account_number": "987654321"}
        ],
        "credit_cards": [
            {"card_type": "Visa", "card_number": "4111111111111111"},
            {"card_type": "MasterCard", "card_number": "5555555555554444"}
        ]
    }
}
```

2. 오버패치 해결방안

- GraphQL

```graphql
query {
  user(id: 1) {
    name
  }
}
```

```json
{
    "data": {
        "user": {
            "name": "John Doe"
        }
    }
}

```

# 단점 1.2 언더패치 예시

1. 상황 : 사용자 정보와 게시물 목록이 필요할 때

```python
# 첫 번째 요청: 사용자 정보 가져오기
user_response = requests.get("https://api.example.com/users/1")
user_data = user_response.json()
```

```python
# 두 번째 요청: 사용자가 작성한 게시물 목록 가져오기
posts_response = requests.get("https://api.example.com/users/1/posts")
posts_data = posts_response.json()
```

2. 언더패치 해결방안

- GraphQL

```graphql
query {
  user(id: 1) {
    username
    email
    posts {
      title
      content
    }
  }
}
```
> 한번의 요청으로 ID : 1 사용자 의 게시물을 가져옴

# 단점 2. 버전 관리의 어려움:

> API가 진화하면서, REST API는 버전 관리를 해야 합니다. 각 버전에 대해 별도의 엔드포인트를 유지해야 하며, 이는 관리의 복잡성을 증가시킵니다.
1. 엔드포인트 복잡성 증가
    1. 기존 API 엔드포인트:
        ```
        GET /api/v1/users
        POST /api/v1/users
        GET /api/v1/users/{id}
        ```
    2. 버전 2의 API 엔드포인트 (새 기능 추가 및 변경):
        ```
        GET /api/v2/users
        POST /api/v2/users
        GET /api/v2/users/{id}
        PATCH /api/v2/users/{id} (새 기능: 사용자 정보 수정)
        ```
2. 데이터 모델의 변경
    1. 버전 1의 데이터 모델:
        ```
        {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com"
        }
        ```
    2. 버전 2의 데이터 모델 (추가 필드 및 필드 이름 변경):
        ```
        {
        "id": 1,
        "full_name": "John Doe",   // 필드 이름 변경
        "email_address": "john@example.com",  // 필드 이름 변경
        "phone_number": "+1234567890"  // 새 필드 추가
        }
        ```

# 단점 3. 복잡한 데이터 구조 처리 어려움:

> 복잡한 관계형 데이터를 다루는 데 REST API는 불편할 수 있습니다. 여러 리소스 간의 관계를 처리하려면 여러 번의 요청이 필요하며, 이는 클라이언트 측에서 추가적인 작업을 요구합니다.

1. 다수의 요청
    - 단점1 언더패치와 비슷한 맥락
    - 예를 들어, 사용자의 게시물과 댓글을 모두 가져오려면 사용자 데이터를 얻기 위한 요청, 게시물을 얻기 위한 요청, 댓글을 얻기 위한 추가 요청이 필요

2. 조합과 변환
    - 내부에서 Logic을 통한 처리가 필요함
    - 각각 resource를 endpoint에 데려온 자원을 토대로 값을 조합, 반환

3. 성능 문제
    - 클라이언트와 서버 간의 데이터 전송량이 많아짐
    - 네트워크 성능에 영향

# 단점 4. 상태 비저장성의 한계:

> 모든 요청이 독립적이어야 하므로, 클라이언트가 상태를 유지해야 하는 경우 구현이 복잡해질 수 있습니다. 예를 들어, 트랜잭션이나 세션 관리가 필요한 경우 REST API는 적합하지 않을 수 있습니다.

```python
@app.route('/', methods=['DELETE'])
def delete_user(user_id):
    try:
        # 데이터베이스 트랜잭션 시작
        cursor.execute('BEGIN TRANSACTION')
        
        # 사용자 삭제
        cursor.execute('DELETE FROM users WHERE id = ?', (user_id,))
        
        # 커밋
        conn.commit()
        
    except Exception as e:
        # 롤백
```
> REST API 자체에서 트랜잭션은 동작이 되지 않지만, DB에서의 트랜젝션은 가능



# 단점 5. 성능 문제
> REST API는 텍스트 기반 프로토콜인 HTTP를 사용하기 때문에, 바이너리 데이터 전송에 비해 효율성이 떨어질 수 있습니다. 또한, HTTP 헤더와 같은 추가적인 데이터가 요청/응답에 포함되므로 오버헤드가 발생할 수 있습니다.

1. HTTP response 패킷
```vbnet
# 56 바이트의 JSON 데이터와 함께 HTTP 헤더
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 56

{
  "id": 1,
  "username": "john_doe",
  "email": "john.doe@example.com"
}
```

2. gRPC 패킷
    1. 바이너리 형식
    ```
    syntax = "proto3";

    service UserService {
    rpc GetUser (UserRequest) returns (UserResponse);
    }

    message UserRequest {
    int32 user_id = 1;
    }

    message UserResponse {
    string username = 1;
    string email = 2;
    }
    ```

    2. 바이너리 직렬화 예시 (Hexadecimal):
    ```
    0a 01 01 10 01

    # 예시의 전체 구조
    - Field Header (0a): user_id 필드의 타입과 번호를 정의합니다.
    - Length of the Value (01): 값의 길이를 나타냅니다.
    - Value (01): user_id의 값인 1을 나타냅니다.
    ```

3. 결론
    1. gRPC : 5바이트, HTTP1.1 : Header byte(80) + json byte(56)
        > 바이트 차이가 많이 남, 데이터 

# 단점 6. REST API 표준 부족
- 단점3. 복잡한 데이터 구조와 유사함
1. 예시
    1. 엔드포인트: /api/users/{user_id}
    ```python
    response = requests.get("http://localhost:5000/api/users/1")
    #결과
    {
    "name": "John Doe",
    "contact": "john.doe@example.com"
    }
    ```

    2. 엔드포인트: /users/{id}
    ```python
    response = requests.get("http://localhost:5000/users/1")
    # 결과
    {
    "username": "john_doe",
    "email": "john.doe@example.com"
    }
    ```
2. 문제
    - 위 예시 response 결과 비슷하나, 일관성이 떨어지고 있음
    - 필드의 이름, 구조가 다르며, 클라이언트가 서로 다른 API를 사용할 때 혼란을 초래

3. 해결방안
    - API 설계에 대한 명확한 규칙과 문서를 작성하고, 팀 간의 표준을 정립하는 것이 중요
    - GraphQL과 같은 다른 API 아키텍처는 이러한 문제를 해결하기 위한 대안으로 자주 고려

# 장점 : 캐시

- flask

```python
@app.route('/data')
@cache.cached(timeout=10)  # 60초 동안 캐시 유지
def get_data():
    print("Fetching data...")
    data = {"value": "This is some data."}
    return jsonify(data)
```

> Flaks 안의 캐시 라이브러리
