## #3 UI Challenge

#### 0. Header
멤버 중에서 변수명 뒤에 ?의 여부를 보고 이게 named parameter에서 해당 parameter가 필수적인지 아닌지 확인해서 작성한다

- Text
style: Textstyle()
ex) color, fontSize, fontWeight,
shade: 숫자가 높을수록 어두워짐
ex) Colors.red.shade900
opacity(0 ~ 1): 작은 값을 줄 수록 투명해짐

> 색상을 주는 다양한 방법
1. color: Colors.white.withOpacity(1),
// 앞에 0xFF를 붙인다
2. color : Color(0xFF181818)
// 앞에 A는 255로 고정
3. color : Color.fromARGB(255, 133, 28, 28)
// O - Opacity
4. color : Color.fromRGBO(133, 28, 28, 1)

- SizedBox : space를 줄 수 있음

- Row : 옆으로 나열하고 싶을 때 
mainAxisAlignment: 수평방향
crossAxisAlignment: 수직방향

- Column : 위아래로 나열하고 싶을 때
mainAxisAlignment: 수직방향
crossAxisAlignment: 수평방향

ex) mainAxisAlignment: MainAxisAlignment.end,
- Padding
padding : EdgeInsets.all(10)
// 상하좌우에 padding 10
padding : EdgeInsets.only() // lrtb 중 하나만 줄 수도 있음
padding : EdgeInsets.symmetric(horizontal : 40)

#### 1. Developer Tools
![](https://velog.velcdn.com/images/chesunny/post/05b7dcf5-041b-4a56-a4e3-93278aaf0693/image.png)
맨 오른쪽에 있는 아이콘 클릭 >  Widget Tree
위젯들이 어떻게 구성되어 있는지 볼 수 있음
ex) crossAxisAlignment, mainAxisAlignment
![](https://velog.velcdn.com/images/chesunny/post/688b7b47-2896-4d84-b7b2-639e9cbe8973/image.png)

다른 정렬 미리보기 및 수정가능 
![](https://velog.velcdn.com/images/chesunny/post/07a7132c-4316-46f4-9e3e-7be5629103c5/image.png)

이 버튼을 활성화시키고 시뮬레이터로 가서 커서로 클릭하면
element 위젯을 선택하는 것이 가능함
![](https://velog.velcdn.com/images/chesunny/post/fa92c52e-8dfc-4646-9841-553cf4c56f6c/image.png)
모든 것의 가이드라인을 보여준다

#### 2. Buttons Section
버튼(박스) 만들기
진짜 $을 넣고 싶으면 이게 변수가 아니라는것을 나타내기 위해 앞에 \을 써줘야됨 
ex) Text('\$5 194 482',)

- Container
html에 있는 div와 유사
child를 가지고 있는 box임
container를 BoxDecoration로 꾸며준다
ex) color, borderRadius

#### 3. VSCode Settings
코드를 컴파일하기 전에 사전에 알 수 있는 변수들은 변수 앞에 const를 붙여서 불필요한 메모리 공간을 만드는 것을 줄인다
-> compiler가 사용자들을 위해 많은 최적화를 할 수 있다
ex) 색깔, SizedBox

setting > command palette > opern user settings 작성 
-> settings.json 파일 ->
```dart
// 코드를 저장하면 자동으로 const를 넣으면 좋은 곳에 작성된다
"editor.codeActionsOnSave": {
        "source.fixAll": "explicit"
    },
// 해당 위젯의 부모가 어딨는지 가이드라인이 보인다
"dart.previewFlutterUiGuides": true,
// 코드를 저장하면 자동으로 코드를 포맷, 정렬한다(필요한 곳에 , 찍음)
"editor.formatOnSave": true,
```
extenstion > error lens 설치
오류가 무엇인지 알려준다
#### 4. Code Actions
전구 모양
기존에 코드들을 복사-붙여넣기로 위젯을 감싸는 행동을 훨씬 수월하게 해준다.
Wrap, Remove로 위젯으로 감싸거나 감싸져있는 위젯을 해제할 수 있다

단축키: (Windows) ctrl + . 이다
리팩토링: 결과의 변경 없이 코드의 구조를 재조정함

#### 5. Reusable Widget
만든 버튼 Container에서 code action으로 extract widget으로 Button 클래스를 만들어준다

st 단축으로 클래스 자동 생성 가능
code action으로 final fields의 생성자를 만들 수 있음
-> create constructor for final fields

외부 파일에서 들어오는 값에 의해 지정되는 필드들에는 const를 작성할 수 없음 주의

lib > widget > button.dart 

```dart
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      		// 해당 컨테이너에 색상을 준다 
        color: bgColor,
        	// 테두리가 둥글게끔 해준다
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Text(text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            )),
      ),
    );
  }
}

```

#### 6. Cards
카드 내의 구성을 Text까지 완성
opacity는 컴파일할때 알기 힘든 값이기 때문에 const를 쓸 수 없다
#### 7. Icons and Transforms
아이콘을 포함한 카드의 크기 자체의 변화없이 아이콘의 크기와 위치만 바꾸기

Transform.scale의 child: child의 크기를 조정 (몇 배)
Transform.translate의 child: child를 offset만큼 이동 (x, y)

CurrencyCard의 Container의 clipBehavior
: 어떤 아이템이 overflow가 되었을 때, 카드와 같은 container로 하여금 어떻게 동작하게끔 할건지 알려주는 장치
Container의 바깥으로 흘러넘치는 컴포넌트들을 어떻게 처리할 것인지
ex) clipBehavior: Clip.hardEdge 

#### 8. Reusable Cards

lib > widget > currency_card.dart 

```dart
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
	// 다르게 주고 싶은 값들을 필드로 빼준다
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final double order;
  // 색상 상수화 - private
  final _blackColor = const Color(0xFF1F2123);

	// 생성자
  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
  	// code challenge
    double offset = 0;
	
    switch (order) {
      case 1:
        offset = 0;
        break;
      case 2:
        offset = -20;
        break;
      case 3:
        offset = -40;
        break;
      default:
        offset = 0;
    }
    return Transform.translate(
    	// Container의 위치 조정
      offset: Offset(0, offset),
      child: Container(
      		// Container 바깥의 아이템들은 모두 잘라내도록 한다
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
        	// 색상이 반전되는 부분 - 조건
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Text(
                      amount,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      code,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ]),
                ],
              ),
              // Icon의 크기 조정
              Transform.scale(
                scale: 2.2,
                // Icon의 위치 조정
                child: Transform.translate(
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
```
SingleChildScrollView: 스크롤이 가능하게끔 해준다 

<Transform.scale>
- Icon의 size 조정: Icon 자체의 크기 조정
:카드(Container)내의 layout 변화 가능
- Icon을 감싸는 Transform.scale의 scale 조정
: 카드(Container)내의 layout 변화없이 Icon의 크기만 변동

<Transform.translate>
- Icon을 감싸는 Transform.translate 
: Icon의 위치를 옮겨준다
- Container를 감싸는 Transform.translate 
: 카드(Container)의 위치를 옮겨준다

#### 9. Code Challenge
카드의 위치를 Transform.translate를 이용해서 옮기는 것을 CurrencyCard 클래스 안에 넣어보기!

--> 나는 main에서 1, 2, 3의 값 중 하나를 받아서 CurrencyCard클래스에서 switch-case문을 사용해서 1일때는 offset이 0, 2일때는 offset이 -20, 3일때는 offset이 -40이 되도록 구현하였다.
그리고 기존에 카드였던 Container를 code action을 통해서 간편히 widget으로 감싸서 묶은 다음에 Transfrom.translate을 작성해주었다.

### 최종 결과와 코드
![](https://velog.velcdn.com/images/chesunny/post/3dbdf7c9-3c30-4b28-b033-7e0e1b4032b3/image.png)

```dart
import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/currency_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        // 스크롤이 가능하게끔한다
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey Selena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '\$5 194 482',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                        text: 'Transfer',
                        bgColor: Colors.amber,
                        textColor: Colors.black),
                    Button(
                        text: 'Request',
                        bgColor: Color(0xFF1F2123),
                        textColor: Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Wallets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                const CurrencyCard(
                  name: 'Euro',
                  code: 'EUR',
                  amount: '6 428',
                  icon: Icons.euro_rounded,
                  isInverted: false,
                  order: 1,
                ),
                const CurrencyCard(
                  name: 'Bitcoin',
                  code: 'BTC',
                  amount: '9 785',
                  icon: Icons.currency_bitcoin,
                  isInverted: true,
                  order: 2,
                ),
                const CurrencyCard(
                  name: 'Dollar',
                  code: 'USD',
                  amount: '428',
                  icon: Icons.attach_money_outlined,
                  isInverted: false,
                  order: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```


> 모든 것을 기억할 필요는 없고 위젯이 어떻게 사용되는지 알아본다
플러터에서는 모든 것이 클래스를 이용해서 위젯으로 간편하게 사용된다 
