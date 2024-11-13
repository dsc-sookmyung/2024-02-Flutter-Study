
## FLutter와 Dart의 동작 원리

Flutter는 UI와 앱의 논리를 모두 Dart로 작성한다.
Dart는 Flutter의 렌더링 엔진과 위젯 시스템을 직접 지원한다.

1. 위젯 기반 구조

   - Flutter는 모든 것을 **위젯**으로 간주한다.
     Flutter의 UI는 여러 위젯을 계층 구조로 쌓아 올려서 완성한다.
   - 각 위젯을 통해 레이아웃, 스타일, 애니메이션 등을 설정할 수 있다.

<br>

2. Flutter 엔진

   - Flutter의 핵심에는 C++로 작성된 엔진이 있다.
     이 엔진이 다양한 플랫폼에 대한 렌더링을 직접 처리한다.
   - 엔진은 모든 UI요소를 직접 그리기 때문에 완전히 독립된 UI를 제공한다.
   - 이 구조 덕에 Android, iOS, 웹에서 동일한 UI가 유지될 수 있다.
  
<br>

3. React Native와의 차이점

   - React Native는 Javascript로 작성되며, 네이티브 컴포넌트를 JS Bridge를 통해 호출하여 UI를 렌더링한다.
   - 반면 FLutter는 자체 엔진으로 모든 UI를 직접 그리기 때문에 브릿지가 필요하지 않다. 이로인해 성능적으로 더 유리할 수 있다.

<br></br>

-------------------------------


## Hello World 실행해보기

1. build 메서드

   `build` 메소드는 매번 위젯이 새로 그려져야 할 때마다 호출되며, 다음과 같은 역할을 한다.

- 위젯의 현재 상태와 데이터에 따라 화면에 그려질 레이아웃을 정의한다.
- 리턴값으로 위젯 트리를 반환하여 엔진이 이를 바탕으로 위젯을 그린다.

  ```dart
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
      title: Text('Hello flutter!'),
      ),
      body: Center(
        child: Text('Hello world!'),
      ),
     ),
    );
  }
}
```

이 예제는 `build` 메서드 **Scaffold**라는 기본 레이아웃 구조를 반환하고, `AppBar`와 `center` 위젯을 통해 텍스트를 보여주는 구조를 정의한다.

- appBar : 화면 상단에 표시될 앱바를 설정한다. 보통 제목이나 메뉴 버튼 등을 배치한다.
- body :  화면의 주요 콘텐츠를 배치하는 영역이다. 


2. `MaterialApp` 위젯

  `MaterialApp` 은 Flutter 애플리케이션의 전체적인 설정을 담당하는 위젯으로, 앱의 최상위 위젯으로 사용된다.

  ### 주요 속성

  - home :  앱이 실행될 때 처음으로 표시할 위젯을 설정한다. 보통 `Scaffold` 위젯을 사용한다.
  - theme : 앱의 전반적인 테마를 설정한다.



