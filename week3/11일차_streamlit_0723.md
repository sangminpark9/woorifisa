# KPT 회고
1. Keep
   - 오늘 옆 자리 친구인 민경은 친구 것 git clone, git push를 해주고 streamlit hub에 추가까지 해주었다. 잘 이해하고 있었다고 생각했지만, 다시 다른 환경, 다른  OS에서 해보니 복습하는 느낌으로 할 수 있어서 좋았다.
   - streamlit Hub 업로드에 큰 어려움이 없었다.

2. Problem
   - pandas 데이터 프레임이랑 칼럼만 따로 설정하는데 어려움이 있었다.
   - 오늘도 수업 쉬는 시간에 백준 문제 1문제만 풀었다는 점…

3. Try
   - 오늘 저녁 pandas 복습을 한 번 하자
   - 백준 문제도 저녁에 풀자!

---
```
#파이썬 작성법 예시
주어.동사(목적어)

#cmd 명령어
주어 동사 --파라미터 변수
   --전체이름 (롱파라미터)
   -n (숏파라미터)
```

```
특정 서비스마다 약속처럼 사용하는 포트가 몇 개 있다.
3300 : DB
22   : 외부에서 내 컴퓨터 명령줄에 접속할 때
```

```
import streamlit as st

#입력화면 - HTML/CCS/JS 로 최종적으로 변환


#함수, 변수 등을 통해 입력받은 값을 출력하기 위한 값으로 제어


#출력화면 - HTML/CSS/JS 로 최종적으로 변환
```

### stream 예제
```python
import streamlit as st

# 입력화면 - 버튼 생성
val1 = st.button("1고양이")
val2 = st.button("2고양이")
val3 = st.button("3고양이")

# 출력 - 선택된 버튼에 따라 다른 이미지 표시
if val1:
    st.image(r"./data/cat1.png", caption="1고양이")
    #st.write("1고양이 버튼이 눌렸습니다.")
elif val2:
    st.image(r"./data/cat2.png", caption="2고양이")
    #st.write("2고양이 버튼이 눌렸습니다.")
elif val3: 
    st.image(r"./data/cat3.png", caption="3고양이")
    #st.write("3고양이 버튼이 눌렸습니다.")
```

### streamlit.text_input()
```python
import streamlit as st

ani_list = ['짱구는못말려', '몬스터','릭앤모티']
img_list = ['https://i.imgur.com/t2ewhfH.png', 
             'https://i.imgur.com/ECROFMC.png', 
             'https://i.imgur.com/MDKQoDc.jpg']

# 검색창 
# 입력창에서 데이터를 받아서 
# 해당 문자열이 일치하는 이미지를 화면에 출력해 보세요.
tmp = st.text_input('애니메이션입력해보세요')

if tmp == '짱구는못말려':
    st.image(img_list[0])

elif tmp == '몬스터':
    st.image(img_list[0])
    
elif tmp == '짱구는못말려':
    st.image(img_list[0])
```

> 처음에 간단히 구현해봤는데,
> 문제점이 ‘짱구는못말려’ 라고 풀 네임을 적어줘야 됐다

> 해결 방법은 zip함수를 활용해서 tuple로 만들고, img라는 것이 in ani_list에 있는지 확인을 하면서 만들어봤다.
```python
import streamlit as st

# 애니메이션 리스트와 이미지 리스트
ani_list = ['짱구는못말려', '몬스터', '릭앤모티']
img_list = ['https://i.imgur.com/t2ewhfH.png', 
            'https://i.imgur.com/ECROFMC.png', 
            'https://i.imgur.com/MDKQoDc.jpg']

# 검색창 생성
tmp = st.text_input('애니메이션을 입력하세요:')

for ani, img in zip(ani_list, img_list):
    #st.write(ani, img)
    if tmp in ani and tmp != '':
        st.image(img)
```

## Streamlit 입출력예시

```python
import streamlit as st
import pandas as pd  # st은 입력과 출력만 담당할 뿐 실제 로직은 나머지 파이썬 코드로 구현됩니다.

data = pd.DataFrame(
    [
       {"command": "st.selectbox", "rating": 4, "is_widget": True},
       {"command": "st.balloons", "rating": 5, "is_widget": False},
       {"command": "st.time_input", "rating": 3, "is_widget": True},
   ]
)


# 입력
st.title('1. 입력버튼들')

button_result = st.button('Hit me')
# 버튼을 누르면 데이터프레임이 등장하도록 로직을 만들어주세요
if button_result == True:
    st.write(button_result)
    st.data_editor(data)

check_result = st.checkbox('Check me out')
if check_result == True:
    st.data_editor(data)

radio_result = st.radio('Pick one:', ['nose','ear'])
st.selectbox('Select', [1,2,3])
st.multiselect('Multiselect', [1,2,3])
st.slider('Slide me', min_value=0, max_value=10)
st.select_slider('Slide to select', options=[1,2,3])

ani_list = ['짱구는못말려', '몬스터','릭앤모티']
img_list = ['https://i.imgur.com/t2ewhfH.png', 
            'https://i.imgur.com/ECROFMC.png', 
            'https://i.imgur.com/MDKQoDc.jpg']

search = st.text_input('Enter some text')
for ani_ in ani_list:
    if search in ani_:
        img_idx = ani_list.index(ani_)

if search != '':
    st.image(img_list[img_idx])

st.number_input('Enter a number')
st.text_area('Area for textual entry')
st.date_input('Date input')
st.time_input('Time entry')
st.file_uploader('File uploader')
st.download_button(
    label="Download data as CSV",
    data=data.to_csv(),
    file_name='app_df.csv',
    mime='text/csv'
)
picture = st.camera_input("Take a picture")

if picture:
    st.image(picture)
    
st.color_picker('Pick a color')

# 출력
st.title('2. 출력메서드들')
st.text('Fixed width text')
st.markdown('_Markdown_') # see #*
st.caption('Balloons. Hundreds of them...')
st.latex(r''' e^{i\pi} + 1 = 0 ''')
st.write('Most objects') # df, err, func, keras!
st.write(['st', 'is <', 3]) # see *
st.title('My title')
st.header('My header')
st.subheader('My sub')
st.code('for i in range(8): foo()')

# * optional kwarg unsafe_allow_html = True
```


## colums 활용

```python
import streamlit as st

# Using object notation
add_selectbox = st.sidebar.selectbox(
    "How would you like to be contacted?",
    ("Email", "Home phone", "Mobile phone")
)
# Using "with" notation
with st.sidebar:
    add_radio = st.radio(
        "Choose a shipping method",
        ("Standard (5-15 days)", "Express (2-5 days)")
    )

    st.write(add_selectbox)
    st.write(add_radio)
    
col1, col2 = st.columns(2)
col1.write('Column 1')
col2.write('Column 2')

# Three columns with different widths
col1, col2, col3 = st.columns([3,1,1])
# col1 is wider

# Using 'with' notation:
with col1:
    st.image('https://i.imgur.com/MDKQoDc.jpg')
with col2:
    st.image('https://i.imgur.com/t2ewhfH.png')
with col3:
    st.image('https://i.imgur.com/ECROFMC.png')
```

## sidebar in pasge

> 위의 코드는  side바를 실행하는데, streamlit에서는 pages라는 폴더를 활용하면  sidebar안으로 app1, app2, app3 Python 파일을 넣어준다.


# 주가 데이터_streamlit 실습

```python
import streamlit as st
import pandas as pd
import FinanceDataReader as fdr
import datetime
import matplotlib.pyplot as plt
import matplotlib
from io import BytesIO
import plotly.graph_objects as go
import pandas as pd
from io import BytesIO

st.title('무슨 주식을 사야 부자가 되려나')

with st.sidebar:
    st.title('회사 이름과 기간을 입력하세요')
    stock_name = st.text_input('회사이름')
    today = datetime.date.today()
    # 날짜 범위 입력 위젯 생성
    start_date, end_date = st.date_input(
        'Select a date range',
        value=(today, today + datetime.timedelta(days=7)))
    button_result = st.button('주가데이터 확인')
date_range=[]
date_range.append(start_date)
date_range.append(end_date)

@st.cache_data
def get_stock_info():
    base_url =  "http://kind.krx.co.kr/corpgeneral/corpList.do"
    method = "download"
    url = "{0}?method={1}".format(base_url, method)
    df = pd.read_html(url, header=0,encoding='euc-kr')[0]
    df['종목코드']= df['종목코드'].apply(lambda x: f"{x:06d}")
    df = df[['회사명','종목코드']]
    return df

def get_ticker_symbol(company_name):
    df = get_stock_info()
    code = df[df['회사명']==company_name]['종목코드'].values
    ticker_symbol = code[0]
    return ticker_symbol
# 코드 조각 추가
if button_result:
    ticker_symbol = get_ticker_symbol(stock_name)
    if ticker_symbol:
        start_p = date_range[0]
        end_p = date_range[1] + datetime.timedelta(days=1)
        df = fdr.DataReader(f'KRX:{ticker_symbol}', start_p, end_p)
        df = df.iloc[:, :6]
        df.index = df.index.date
        
        st.subheader(f"[{stock_name}] 주가 데이터")
        st.dataframe(df.tail(7))
        st.line_chart(df.Close)
        
        excel_data = BytesIO()
        csv_data = BytesIO()
        
        col1, col2 = st.columns(2)

        df.to_csv(csv_data)
        csv_data.seek(0)  # 포지션 재설정
        df.to_excel(excel_data)
        csv_data.seek(0)  # 포지션 재설정
        with col1:
            st.download_button("CSV 파일 다운로드",
                            csv_data, file_name='sotck_data.csv')
        with col2:    
            st.download_button("엑셀 파일 다운로드",
                    excel_data, file_name='stock_data.xlsx')
else :
    st.error("유효하지 않은 회사 이름입니다. 다시 입력해주세요.")
```

# Git 활용


$ git init
# echo A >> B : B라는 제목,확장자의 파일을 생성하고 A라는 내용을 넣어주겠다
$ echo "# first_repo2" >> README.md
$ git add . # git add * : 변화가 있는 모든 파일을 추가
$ git status 
# $ git commit : 편집기로 들어가게 됨

```python
$ git config --global user.email "renopark05@gmail.com"
$ git config --global user.name "sangminpark9"


$ git commit -m "first commit" # 커밋에는 메시지가 필요하다
$ git status # clean~
$ git log # commit
$ git remote add origin https://github.com/sangminpark9/streamlit01.git
$ git remote # 상태 확인
$ git branch -M main # 해당 레파지토리에서 어떤 브랜치를 사용할 것인지 지정
$ git push origin main # origin이라는 원격저장소(깃허브서버)에 main 브랜치를 보내겠다
```

# streamlit 파일을 활용해서 만들어보았다.