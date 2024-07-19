<h1> KPT 회고</h1>

1. Keep
  - 백준 문제를 꾸준히 풀 수 있었다는 점

2. Problem
  - matplotlib 복잡하게 구현하려면 시간이 걸린다
  - numpy와 pandas도 아직 헷갈리는 듯

3. Try
  - matplotlib 관련 프로젝트를 진행하면 익숙해질 것
  - numpy, pandas도 똑같지 않을까
---

<h1> 1. 판다스 apply</h1>

```python
def func(x) :
    if x.반 == '미나리':
        return '강서구'
    elif x.반 == '개나리' :
        return '강동구'
    elif x.반 == '장미' :
        return '광명시'
    else :
        return '보류'

jjangu_list['분점1'] = jjangu_list.반.apply(func)
#열(column)에 '분점1'을 추가해주고 반에 따라서 제출해줌
```

```python
def add_one(x): #라는 함수가 있다고 하자
    return x+1

add_one(jjangu_list.테스트점수)
jjangu_list.테스트점수.apply(add_one)
# 2가지 방법도 다 동작한다.
```

```python
# filter - 컬럼명에서 원하는 문자/문자열을 쉽게 검색할 수 있습니다
jjangu_list.filter(items=['이름', '담당']) # 열 중심
"""
이름	담당
0	짱구	나미리
1	짱아	채성아
3	맹구	나미리
4	유리	나미리
5	훈이	나미리
6	짱구아빠	채성아
7	짱구엄마	채성아
8	짱구엄마2	채성아
20	짱구엄마2	채성아
"""
```

```python
jjangu_list.filter(items=[8, 20], axis=0)  # 값 자체
"""
이름	등록일자	테스트점수	담당	반
8	짱구엄마2	2023-03-15	85.0	채성아	개나리
20	짱구엄마2	2023-03-15	85.0	채성아	개나리
"""
```

```python
jjangu_list.filter(regex='담.')  # 정규식
"""
	담당
0	나미리
1	채성아
3	나미리
4	나미리
5	나미리
6	채성아
7	채성아
8	채성아
20	채성아
"""
```

```python
jjangu_list.filter(like='스트') # 중간
"""
	테스트점수
0	60.0
1	67.0
3	70.0
4	75.0
5	78.0
6	66.0
7	85.0
8	85.0
20	85.0
"""
```

```python
jjangu_list.isin(['짱구'])
"""
이름	등록일자	테스트점수	담당	반
0	True	False	False	False	False
1	False	False	False	False	False
3	False	False	False	False	False
4	False	False	False	False	False
5	False	False	False	False	False
6	False	False	False	False	False
7	False	False	False	False	False
8	False	False	False	False	False
20	False	False	False	False	False
"""
```

```python
# isin - 데이터에서 원하는 문자/문자열을 쉽게 검색할 수 있습니다
jjangu_list[jjangu_list.이름.isin(['짱구'])]
"""
이름	등록일자	테스트점수	담당	반
0	짱구	2023-03-11	60.0	나미리	장미
"""
```

```python
# contains, startswith, endswith - 일부라도 일치하면 결과 출력 / 정규식 적용
jjangu_list[jjangu_list.이름.str.contains('짱구')]
"""
	이름	등록일자	테스트점수	담당	반
0	짱구	2023-03-11	60.0	나미리	장미
6	짱구아빠	2023-03-16	66.0	채성아	개나리
7	짱구엄마	2023-03-17	85.0	채성아	개나리
8	짱구엄마2	2023-03-15	85.0	채성아	개나리
20	짱구엄마2	2023-03-15	85.0	채성아	개나리
"""

```python
jjangu_list[jjangu_list.이름.str.startswith('짱구')]
"""
이름	등록일자	테스트점수	담당	반
0	짱구	2023-03-11	60.0	나미리	장미
6	짱구아빠	2023-03-16	66.0	채성아	개나리
7	짱구엄마	2023-03-17	85.0	채성아	개나리
8	짱구엄마2	2023-03-15	85.0	채성아	개나리
20	짱구엄마2	2023-03-15	85.0	채성아	개나리
"""
```

```python
jjangu_list[jjangu_list.이름.str.endswith('구')]
"""
	이름	등록일자	테스트점수	담당	반
0	짱구	2023-03-11	60.0	나미리	장미
6	짱구아빠	2023-03-16	66.0	채성아	개나리
7	짱구엄마	2023-03-17	85.0	채성아	개나리
8	짱구엄마2	2023-03-15	85.0	채성아	개나리
20	짱구엄마2	2023-03-15	85.0	채성아	개나리
"""
```

```python
jjangu_list[jjangu_list.이름.str.endswith('구')]
"""
이름	등록일자	테스트점수	담당	반
0	짱구	2023-03-11	60.0	나미리	장미
3	맹구	2023-03-14	70.0	나미리	장미
"""
```

<h1> 2. 판다스 실습</h1>

```python
# dataframe
data = {'country': ['Belgium', 'France', 'Germany', 'Netherlands', 'United Kingdom'],
        'population': [11.3, 64.3, 81.3, 16.9, 64.9],
        'area': [30510, 671308, 357050, 41526, 244820],
        'capital': ['Brussels', 'Paris', 'Berlin', 'Amsterdam', 'London']}

countries = pd.DataFrame(data)
countries.describe(include='all').T

####초기에 data 확인
countries.head()
countries.tail()
countries.info()

countries['density'] = countries.population * 1000000 / countries.area
countries
"""
country	population	area	capital	density
0	Belgium	11.3	30510	Brussels	370.370370
1	France	64.3	671308	Paris	95.783158
2	Germany	81.3	357050	Berlin	227.699202
3	Netherlands	16.9	41526	Amsterdam	406.973944
4	United Kingdom	64.9	244820	London	265.092721
"""
```

```python
countries[countries.density > 300]
"""
country	population	area	capital	density
0	Belgium	11.3	30510	Brussels	370.370370
3	Netherlands	16.9	41526	Amsterdam	406.973944
"""
```

```python
#실습3 : 'density_ratio' 칼럼을 추가해주세요. (density_ratio = 인구밀도/평균 인구밀도)
countries.density / countries.density.mean()
countries['density_ratio'] = countries.density / countries.density.mean()
countries.loc[countries.density > 300, ['capital', 'density']]
```

```python
실습4 : 영국(United Kingdom)의 수도(capital)를 'Cambridge'로 변경해주세요.
countries.capital = countries.capital.replace('London','Cambridge')
countries.capital = countries.capital.replace('London','Cambridge',regex = True) #정규식 포함
"""
country	population	area	capital	density	density_ratio
0	Belgium	11.3	30510	Brussels	370.370370	1.355755
1	France	64.3	671308	Paris	95.783158	0.350618
2	Germany	81.3	357050	Berlin	227.699202	0.833502
3	Netherlands	16.9	41526	Amsterdam	406.973944	1.489744
4	United Kingdom	64.9	244820	Cambridge	265.092721	0.970382
"""
```

```python
#판다스에서 칼럼의 len을 확인하려면
countries.capital.str.len() >= 7 #조건식
"""
0     True
1    False
2    False
3     True
4     True
Name: capital, dtype: bool
"""
```

```python
countries.capital[countries.capital.str.len() >= 7]
"""
0     Brussels
3    Amsterdam
4    Cambridge
Name: capital, dtype: object
"""
```
---

<h1> 3. CDA, EDA</h1>

**확증적 데이터 분석(CDA: Confirmatory Data Analysis)**
가설을 설정한 후, 수집한 데이터로 가설을 평가하고 추정하는 전통적인 분석

**탐색적 데이터 분석(EDA: Exploratory Data Analysis)**
원 데이터(Raw data)를 가지고 **유연하게 데이터를 탐색**하고, 데이터의 특징과 구조로부터 얻은 정보를 바탕으로 통계모형을 만드는 분석방법. 주로 빅데이터 분석에 사용된다. 

---

<h1> 4. matplotlib</h1>

```python
#matplotlib
# %matplotlib inline  # 버전이 낮은 노트북에서 그래프가 바로 뜨지 않을 때 사용 % 쉘메소드

import matplotlib as mpl  # 기본 설정 만지는 용도
import matplotlib.pyplot as plt  # 그래프 그리는 용도
import matplotlib.font_manager as fm # 폰트 관련 용도

# 현재 설치된 폰트 확인해보기
sys_font=fm.findSystemFonts()
print(f"sys_font number: {len(sys_font)}")
print(sys_font)

nanum_font = [f for f in sys_font if 'Nanum' in f]
print(f"nanum_font number: {len(nanum_font)}")

# 시각화도 결국...
import numpy as np
# 한글 폰트 설정
plt.rc('font', family='NanumBarunGothic')
# - 기호 깨짐 현상 방지를 위한 설정
plt.rc('axes', unicode_minus=False)

plt.plot(x, y);  # 메모리 주소를 출력하지 않음

"""
linestyle
'-' : solid
'--' : dashed
'-.' : 'dashdot
':' : dotted
예시 - np.random.randn(30).cumsum()
"""
```

```python
plt.plot(x, y,  marker='x', linestyle='dashdot', color='#00FF00');

plt.plot(x,y, 'gx-.')
#결과는 같다.
#물론 00FF00값의 색은 아님
======

plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.axis([-5, 50, -5, 5]) # 좌 우 하 상 - 축의 범위를 고정할 때

=======

plt.plot(np.random.randn(30).cumsum())
plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.plot(np.random.randn(30).cumsum(), 'b--^')
plt.show() # 위 내용까지만 하나의 도화지를 공유

plt.plot(np.random.randn(30).cumsum())
plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.plot(np.random.randn(30).cumsum(), 'b--^')
plt.show() # 위 내용까지만 하나의 도화지를 공유


plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.([-5, 50, -5, 5]) # x축의 범위
# y축의 범위

=============

plt.plot(np.random.randn(30).cumsum())
plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.plot(np.random.randn(30).cumsum(), 'b--^')
plt.show() # 위 내용까지만 하나의 도화지를 공유

plt.plot(np.random.randn(30).cumsum())
plt.plot(np.random.randn(30).cumsum(), 'g-.x')
plt.plot(np.random.randn(30).cumsum(), 'b--^')
plt.show() # 위 내용까지만 하나의 도화지를 공유

=====
plt.plot(x, y1, color='blue', label='line L')
plt.plot(x, y2, color='orange', label='line h')

plt.legend(loc='upper right')

plt.title('Line Graph Exapmle')
plt.xlabel('x axis')
plt.ylabel('y axis')
plt.show()
```

<h1> 5. 백준 12789 도키도키 간식드리미</h1>

```python
# 초반 스택에 넣는 것 까지는 쉬웟다고 생각한다.

import sys
import math

if __name__ == '__main__':
    n = int(sys.stdin.readline().rstrip())
    stack = []
    order = 1
    arr = list(map(int, sys.stdin.readline().rstrip().split()))

    for element in arr: # 입력 순서대로 진행
        if element == order: # 간식을 받았다고 확인
            order += 1
        else:
            stack.append(element)

    while True: # 하나씩 pop
        if len(stack) == 0: # stack이 비었다면
            print('Nice')
            break
        if stack[len(stack) -1] == order:
            order += 1
            stack.pop()
        else: # 실패
            print('Sad')
            break
```

  - 위 코드를 제출하면 틀린다고 나오는데,,, 아마 list에 append할 때 스택을 소모 안해서
  - 틀린 것

```python
# stack 리스트에 넣는다고 했을 때, 담겨있는 stack을 소모할 수
# 있으면 소모 시키는 방법으로 코딩
import sys
import math

if __name__ == '__main__':
    n = int(sys.stdin.readline().rstrip())
    stack = []
    order = 1
    arr = list(map(int, sys.stdin.readline().rstrip().split()))

    for element in arr: # 입력 순서대로 진행
        if element == order: # 간식을 받았다고 확인
            order += 1
        else:
            # append하기 전에 stack소모
            while True: # 하나씩 pop
                if len(stack) == 0: # stack이 비었다면
                    break
                if stack[len(stack) -1] == order:
                    order += 1
                    stack.pop()
                else: # 실패
                    break
            stack.append(element)

        # 남은 Stack 소모
        while True: # 하나씩 pop
            if len(stack) == 0: # stack이 비었다면
                break
            if stack[len(stack) -1] == order:
                order += 1
                stack.pop()
            else: # 실패
                break

    # 끝
    if len(stack) == 0: # stack이 비었다면
        print('Nice')
    else: # 실패
        print('Sad')
```

> 위 코드로 고치는데 사용한 testcase는 아래와 같다

```python
10
5 4 3 2 1 10 9 8 7 6
```
