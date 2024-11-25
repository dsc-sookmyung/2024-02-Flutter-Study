### 4.0 State
**Stateless Widget**   
: build 메서드를 통해 UI 출력
데이터를 가지고 있지 않고 변경되지 않을 UI를 출력

**Stateful Widget**   
: 상태가 없는 위젯 부분 + 상태를 가지고 있는 부분(데이터와 UI를 가진다)   
위젯에 데이터를 저장하고 싶거나 실시간으로 데이터 변화를 반영하고 싶을때 Stateful Widget을 사용한다.   
state의 데이터를 바꿀 때, 우리의 UI는 새로고침되면서 최신 데이터를 보여준다   
여기서 데이터는 단지 클래스 프로퍼티(단순 dart property)이다 -> 아직 flutter아님   

stateful widget을 생성하는 방법   
1. stateful widget는 st만 작성 (stateful 선택)    
2. stateless Widget에서 stateful widget으로 변경(code action에서 convert to statefulwidget)    

### 4.1 setState   
**setState**   
: State 클래스에게 데이터가 변경되었다고 알리는 함수   
1. 새로운 데이터가 들어왔다고 알려준다    
2. UI를 새로고침해달라고 요청함 (build 메서드 다시 실행)    

굳이 데이터의 변화를 꼭 setState함수 안에 넣어야할 필요는 없다!   
-> 가독성이 좋게하기 위함   
```dart
void onClicked() {
	counter = counter + 1;
    setState(() {});
  }
```
### 4.2 Recap
```dart
List<int> numbers = [];
void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }
```
리스트에 0, 1, 2, ..이 들어올 것이다

setState가 react에서 쓰이는 만큼 쓰이지는 않을것임
만약 setState를 쓰지 않고 데이터값만 바꾼다면 콘솔에는 바뀐 값이 나타나겠지만 화면에는 나타나게 되지 않을 것이다. 

### 4.3 BuildContext
**ThemeData**   
예전에 TextStyle을 일일히 설정했던 번거로움을 없애준다
```dart
theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
``` 

**BuildContext**   
build메소드의 매개변수   
위젯트리에서 위젯의 위치를 제공   
자식위젯이 부모의 위젯에 접근하고 싶을 때 사용   
매우 먼 요소의 데이터를 가져올 수 있기 때문에 매우 유용   

<Widget Tree\>   
flutter가 애플리케이션을 어떻게 렌더링하는지 보여주는 그림
![](https://velog.velcdn.com/images/chesunny/post/809cd02b-3ade-4059-b49f-0ceec4d62359/image.png)

context란 text이전에 있는 모든 상위요소들에 대한 정보이다   

우리가 null값에 접근할 수 있는 경우들을 방지   
```dart
color: Theme.of(context).textTheme.titleLarge?.color,
// !도 사용 가능
```


### 4.4 WidgetLifecycle
init -> build -> dispose   

**initState**   
: 상태를 초기화하기 위한 메서드   
부모요소에 의존하는 데이터를 초기화해야하는 경우 사용 (context 사용하고자 하는 경우)   
변수 초기화, api에서 업데이트를 구독   
- initState메서드는 항상 build메서드보다 먼저 호출되어야한다   
- 그리고 단 한번만 호출되어야함   

**dispose**   
위젯이 스크린, 위젯트리에서 제거될때 호출되는 메소드   
api 업데이트나 이벤트 리스너로부터 구독을 취소하거나   
form의 리스너로부터 벗어나고 싶을때 사용   

### 최종 코드
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showTitle = true;

  // int counter = 0;
  // List<int> numbers = [];
/*
  void onClicked() {
    setState(() {
      counter = counter + 1;
    });
  }
*/
/*
  void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }
*/

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                onPressed: toggleTitle,
                icon: const Icon(Icons.remove_red_eye),
              )
              /*
            Text(
              '$counter',
              style: const TextStyle(fontSize: 30),
            ),*/
              //for (var n in numbers) Text('$n'),
              /*IconButton(
              iconSize: 40,
              onPressed: onClicked,
              icon: const Icon(
                Icons.add_box_rounded,
              ),
            )*/
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Text(
      //'Click Count',
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}

```
![](https://velog.velcdn.com/images/chesunny/post/a9a28a04-239a-42ea-b00a-a8acc1a85a32/image.png)
