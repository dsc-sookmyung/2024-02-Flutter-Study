# flutter 4주차 _ study 
## 3.0 Header 생성
![](image.png)<!-- {"width":227} -->
![](image%202.png)

- Row의 MainaxisAlignment : 수평방향
  - Row의 CrossAxis: 세로방향
- Column의 MainaxisAlignment : 수직방향
  - Column의 CrossAxis: 가로방향 
- SizedBox
- color 표현 방법
  - hexcode : backgroundcolor(Color(0xff181818))
  - RGB :ColorfromRGBO(R, G, B, Opacity)


## 3.1 Developers Tools
![](image%203.png)<!-- {"width":583} -->![](image%204.png)


### 가이드라인
![](image%205.png)

## 3.2 Buttons Section
![](image%206.png)
- Total Balance text와 두 개의 버튼을 구현 
- $ <- escaping (dart 언어에서는 ‘$변수명’을 구문으로 사용하기 때문에 escaping이 필요하다. 
  - ’\\$5 194 482' 따라서 달러 표시 앞에 역슬래시(\\) 기호를 넣어주면 ‘따옴표 안의 모든 문자가 문자열로 인식 된다. 
![](image%207.png) 

## 3.3 VScode Settings
### vscode에서 파란줄이 뜨는 이유
![](image%208.png)
- 파란줄에 마우스 호버하면 경고문이 뜬다. 
 내용은 -> [constant constructors는 const를 사용하는 것을 추천 한다. ]
Dart 언어는 constant(상수) 개념을 지원함. 
 *constant는 절대 바뀌지 않는 변수이자, value의 값을 사전에 알 수 있는 변수 
 
파란 줄의 경고문을 모두 const로 바꿔주기에는 시간적 제약과 const와 var타입의 구분의 어려움이 따른다. 따라서 vscode의 command palette > preferences: Open User Settings(JSON)을 열어 다음과 같이 
 ![](image%209.png)

"editor.codeActionsOnSave": {
        "source.fixAll": true
    },
-> Vscode에서 자체적으로 const를 생성해준다. 

    "dart.previewFlutterUiGuides": true,
 ![](image%2010.png)  -> 위와 같이 가이드의 값을 true로 주고 vscode를 껐다 켜보면 


![](image%2011.png)

