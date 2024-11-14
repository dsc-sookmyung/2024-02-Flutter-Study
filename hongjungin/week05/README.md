## Flutter의 Stateful Widget 이해하기

Flutter에서 UI를 구축할 때 사용되는 위젯은 크게 두 가지로 나뉩니다.

- Stateless Widget: 

- Stateful Widget: Stateful Widget은 상태를 가지고 있어, 데이터 변화에 따라 UI를 갱신할 수 있는 특징이 있습니다.

------------------------------

> Stateful Widget이란?

Stateful Widget은 상태를 가질 수 있는 위젯으로, 데이터가 변할 때마다 해당 위젯이 다시 빌드(build)되어 실시간으로 UI가 업데이트됩니다.

Stateful Widget은 또 두 부분으로 나뉩니다.

1. 위젯 자체 (StatefulWidget 클래스): UI의 기본적인 구조를 정의합니다. 상태를 생성하는 역할을 하며, 상태가 변할 때마다 build 메서드가 호출됩니다.

2. 위젯의 상태 (State 클래스): 위젯의 데이터를 관리하며, 데이터가 변경될 때 `setState()` 를 호출하여 UI를 다시 빌드합니다. 상태는 위젯이 삭제될 때까지 유지됩니다.

### Stateful Widget과 Stateless Widget의 차이

| 구분             | Stateless Widget                         | Stateful Widget                        |
|------------------|------------------------------------------|----------------------------------------|
| **상태**         | 없음                                     | 있음                                   |
| **UI 갱신**      | UI 고정 (데이터 변경 시 새로 빌드 안 됨) | 데이터 변경 시 UI 자동 갱신            |
| **사용 예시**    | 단순 UI 표시, 상호작용 없는 위젯         | 버튼 클릭, 텍스트 필드 입력 등 상호작용 필요 |
| **사용 목적**    | 정적 화면                                | 동적 화면                              |
| **성능**         | 상대적으로 가벼움                        | 상태 관리로 인해 상대적으로 무거움      |


### Stateful Widget 구조 설명

- StatefulWidget 클래스: 기본적인 UI와 State 객체를 생성하는 `createState()` 메서드를 정의합니다.

- State 클래스: 상태 데이터와 UI를 정의하는 `build()` 메서드를 포함하고, 데이터가 변경될 때마다 `setState()` 메서드를 호출해 UI를 갱신합니다.

코드 예제 

```dart
// Stateful Widget 정의
class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

// State 클래스 정의
class _AppState extends State<App> {
  int counter = 0; // 상태 데이터

  void onClicked() {
    setState(() {
      counter += 1; // counter 증가
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Click Count'),
              Text('$counter'), // 카운터 출력
              IconButton(
                iconSize: 40,
                onPressed: onClicked, // 버튼 클릭 시 onClicked 호출
                icon: const Icon(Icons.add_box_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- `counter` 변수는 클릭 수를 저장합니다.

- `onClicked()` 메서드는 `counter` 값을 증가시키고, `setState()`를 호출하여 UI를 다시 빌드합니다.

- `IconButton` 위젯은 사용자가 클릭할 때마다 `onClicked` 메서드를 호출하여 `counter`가 증가합니다.

<br></br>

### `setState()` 메서드

`setState()`는 상태가 변경되었음을 Flutter에 알리는 메서드입니다. 이 메서드가 호출되면 Flutter는 해당 위젯의 `build()` 메서드를 다시 호출하여 UI를 갱신합니다.
이 과정을 통해 UI가 최신 상태를 반영하게 됩니다.

```dart
void onClicked() {
  setState(() {
    counter += 1;
  });
}
```

위 코드에서 `setState()` 안에 `counter` 증가 코드를 넣어, 클릭할 때마다 UI에 변경된 `counter` 값이 반영됩니다.

<br>

--------------------------------------------------

이 실습은 Flutter에서 리스트에 데이터를 추가하고 이를 실시간으로 화면에 출력하는 것입니다.
`for`문을 활용해서 Flutter UI를 갱신할 수 있는 실습 코드입니다.

```dart
class _AppState extends State<App> {
  List<int> numbers = []; // 정수형 리스트를 초기화

  void onClicked() {
    setState(() {
      // 리스트에 현재 리스트의 길이를 추가
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(fontSize: 30),
              ),
              // 리스트의 각 요소를 Text 위젯으로 출력
              for (var n in numbers) Text('$n'),
              IconButton(
                iconSize: 40,
                onPressed: onClicked, // 버튼 클릭 시 onClicked 메서드 호출
                icon: const Icon(Icons.add_box_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- for 루프 (for (var n in numbers) Text('$n')):

    - numbers 리스트의 각 요소를 순회하며, 요소 하나당 하나의 Text 위젯을 생성합니다.

    - $n을 사용하여 리스트에 있는 정수 값을 문자열로 변환해 출력합니다.

    - 리스트에 값이 추가될 때마다 새로운 Text 위젯이 생성되어 화면에 표시됩니다.
