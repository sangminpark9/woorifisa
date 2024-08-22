# 장점
1. 단순성과 사용 용이성:

>REST API는 HTTP 표준을 기반으로 하기 때문에 이해하고 사용하기 쉽습니다. 웹 개발자에게 친숙한 GET, POST, PUT, DELETE 등의 HTTP 메서드를 사용합니다.

2. 확장성:

> REST는 클라이언트와 서버 간의 상호 작용을 느슨하게 결합하기 때문에, 시스템을 확장하거나 변경할 때 유연성을 제공합니다. 서버 측의 변경이 클라이언트 측에 큰 영향을 미치지 않습니다.

3.언어 및 플랫폼 독립성:

> REST API는 JSON, XML, HTML 등 다양한 형식을 사용하여 데이터를 교환할 수 있으며, 클라이언트와 서버는 서로 다른 언어와 플랫폼을 사용할 수 있습니다.

4. 캐싱 지원:

> REST API는 HTTP 프로토콜의 기본 기능인 캐싱을 지원합니다. 이를 통해 요청 결과를 캐싱하여 서버 부하를 줄이고, 응답 속도를 높일 수 있습니다.

5. 상태 비저장성:

> REST API는 상태 비저장성을 유지하여 각 요청이 독립적이며, 서버는 클라이언트의 이전 요청 상태를 기억할 필요가 없습니다. 이는 서버의 확장성과 성능을 향상시킵니다.

6. 보안성:

> REST API는 HTTPS를 통해 보안 통신을 지원할 수 있으며, OAuth와 같은 인증 및 권한 부여 메커니즘을 쉽게 통합할 수 있습니다.

# 단점

1. 오버패칭과 언더패칭 문제:

> REST API는 고정된 엔드포인트를 사용하기 때문에, 클라이언트가 필요로 하는 데이터만 정확히 제공하지 못할 수 있습니다. 오버패칭(불필요한 데이터 전송)과 언더패칭(필요한 데이터를 여러 번에 나눠 요청) 문제가 발생할 수 있습니다.

2. 버전 관리의 어려움:

> API가 진화하면서, REST API는 버전 관리를 해야 합니다. 각 버전에 대해 별도의 엔드포인트를 유지해야 하며, 이는 관리의 복잡성을 증가시킵니다.

3. 복잡한 데이터 구조 처리 어려움:

> 복잡한 관계형 데이터를 다루는 데 REST API는 불편할 수 있습니다. 여러 리소스 간의 관계를 처리하려면 여러 번의 요청이 필요하며, 이는 클라이언트 측에서 추가적인 작업을 요구합니다.

4. 상태 비저장성의 한계:

> 모든 요청이 독립적이어야 하므로, 클라이언트가 상태를 유지해야 하는 경우 구현이 복잡해질 수 있습니다. 예를 들어, 트랜잭션이나 세션 관리가 필요한 경우 REST API는 적합하지 않을 수 있습니다.

5.성능 문제:

> REST API는 텍스트 기반 프로토콜인 HTTP를 사용하기 때문에, 바이너리 데이터 전송에 비해 효율성이 떨어질 수 있습니다. 또한, HTTP 헤더와 같은 추가적인 데이터가 요청/응답에 포함되므로 오버헤드가 발생할 수 있습니다.

6. API 표준 부족:

> REST는 아키텍처 스타일로, 구체적인 구현 표준이 부족합니다. 이는 REST API를 설계하는 데 있어서 일관성을 유지하기 어렵게 만들고, 서로 다른 REST API 간의 상호 운용성을 저해할 수 있습니다.


# 1.1 오버패치 예시

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

# 오버패치 해결방안

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

# 1.1 언더패치 예시
### 상황 : 사용자 정보와 게시물 목록이 필요할 때
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

# 언더패치 해결방안

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

# 4. 장점 : 캐시

- flask

```python
@app.route('/data')
@cache.cached(timeout=10)  # 60초 동안 캐시 유지
def get_data():
    print("Fetching data...")
    data = {"value": "This is some data."}
    return jsonify(data)
```

<img width="567" alt="image-2" src="https://github.com/user-attachments/assets/2fa6917b-053c-4b55-b06f-26dec6fe1ddf">
<img width="425" alt="image-3" src="https://github.com/user-attachments/assets/58fc967e-2049-4d7f-953c-cbe89c4d406b">


# 단점 : REST API 표준 부족
- 상황
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

