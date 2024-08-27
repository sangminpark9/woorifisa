# Flask 장점
1. 마이크로 프레임 워크
   > 기본적으로 가벼운 프레임워크로, 필요한 기능만을 추가할 수 있음
   - 간결한 코드
   ```python
   from flask import Flask
   app = Flask(__name__)
   @app.route('/')
   def hello():
   	return "Hello, World!"
   if __name__ == '__main__':
   	app.run(debug=True)
   ```

   - 필요한 기능만 추가(효율성, 간결성)
   > 불필요한 기능이 없으므로, 코드가 간결하고 이해하기 쉬운 구조로 유지
   > API의 구조나 응답 포맷을 자유롭게 정의
   ```python
   from flask import Flask, jsonify, request
   # ORM 선택
   from flask_sqlalchemy import SQLAlchemy
   # API 선택
   from flask_restful import Api, Resource
   
   app = Flask(__name__)
   
   # ORM
   app.config['DATABASE_URI'] = 'sqlite:///mydatabase.db' 
   db = SQLAlchemy(app)
   
   # API
   api = Api(app)
   ```
   
      
# Flask 단점
1. 보안설정 수동관리
   > 설정을 추가하지 않으면 보안상의 취약점이 발생할 수 있음.
   > 모든 설정을 개발자가 수동으로 관리해야 하므로 복잡성이 증가
```python
from flask import Flask, render_template, request
from flask_wtf import CSRFProtect

app = Flask(__name__)
app.config['SECRET_KEY'] = '안전한_비밀키'  # 실제 사용 시 안전한 비밀키로 변경
csrf = CSRFProtect(app)

@app.route('/submit', methods=['POST'])
def submit():
	return "Form submitted!"

```

2. 대규모 애플리케이션 개발 시 복잡성 증가
> 파일 구조와 설정을 체계적으로 관리해야하는 점.
```
my_flask_app/
│
├── app.py # 애플리케이션의 메인 파일
├── requirements.txt # 필요한 패키지 목록
└── templates/ # HTML 템플릿 파일들
	└── index.html # 예시 HTML 파일
```

```
my_flask_app/
│
├── app/
│ ├── __init__.py # 애플리케이션 팩토리 및 초기화
│ ├── routes.py # 라우팅 및 뷰 함수
│ ├── models.py # 데이터베이스 모델
│ ├── forms.py # Flask-WTF 폼 정의
│ └── static/ # 정적 파일 (CSS, JS, 이미지 등)
│ 		└── style.css
│ └── templates/ # HTML 템플릿
│ 		└── index.html
│
├── config.py # 설정 파일
├── run.py # 애플리케이션 실행 스크립트
└── requirements.txt # 필요한 패키지 목록
```

3. Django에 비해 Flask는 상대적으로 작은 커뮤니티와 플러그인 생태계
GitHub 통계:
* 장고는 플라스크보다 더 많은 스타와 포크 수
- Django가 더 많은 개발자들이 관심을 가지고 있음
<img width="1012" alt="image" src="https://github.com/user-attachments/assets/9791b316-42e0-44fa-9d8b-5a1f32e15d11">

[django/django: The Web framework for perfectionists with deadlines.](https://github.com/django/django)
<img width="1023" alt="image 2" src="https://github.com/user-attachments/assets/bb3b02c3-633c-47b4-bf91-192aab4acd39">
[pallets/flask: The Python micro framework for building web applications.](https://github.com/pallets/flask)

⠀Stack Overflow 활동:
* 장고 관련 질문과 답변의 수가 플라스크보다 많음
 장고 : 312,783 questions, 플라스크 : 55,761 questions
<img width="764" alt="image 3" src="https://github.com/user-attachments/assets/8a850862-6cea-4162-a93a-8f63bb0e9ce2">
[Newest 'django' Questions](https://stackoverflow.com/questions/tagged/django)
<img width="764" alt="image 4" src="https://github.com/user-attachments/assets/bc0d2f1a-a5c6-489f-8744-addc4419a811">
[Newest 'flask' Questions](https://stackoverflow.com/questions/tagged/flask)
