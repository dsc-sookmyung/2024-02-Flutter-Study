## 1. Introduction
#### Framework
다트 코드는 Flutter 프레임워크를 이용하여 작성된다
#### Engine
Flutter 프레임워크를 이용해 작성된 다트 코드를 실행시켜 화면상에 보여지도록 하는 역할
어플리케이션의 실제 UI를 렌더링하는데 사용된다
C, C++로 작성되었다

#### Embedder
호스트 플랫폼 상에서 엔진을 가동시키는 역할
특정 플랫폼에 특화된 것
엔진을 가동시키는 runner 프로젝트를 가리킨다
운영체제에 따른 다양한 Embedder가 존재한다
### 특징
운영체제와 직접적으로 대화하지 않는다 (엔진 사용)
Flutter는 사용자의 운영체제에 내장됨 플랫폼 위젯을 사용하지 않는다.
나의 핸드폰이나 컴퓨터(운영체제)가 해주는 일은 오직 엔진을 동작시키는 역할만 수행한다
다양한 운영체제에서 동일하게 디자인 된 상태로 사용할 수 있다

runner 프로젝트는 엔진을 구동 -> 엔진이 프레임워크를 동작 -> 엔진이 화면상에 그려준다
#### 장점과 단점
단점 : 네이티브 위젯을 사용하지 않는다
이것은 운영체제에 의해 그려지는 것이 아니기 때문에 native 위젯처럼 보이려고 해도 이것은 가짜다
장점 : 화면상의 모든 픽셀을 조정할 수 있다
어플리케이션의 호스트에 의존할 필요가 없다

#### 비유
조개구슬: 앱과 플러터 프레임워크 코드
조개 껍데기: 엔진(무언가를 그려주는 역할)
--> flutter 어플리케이션은 플랫폼의 Native Widget을 사용하지 않는다
바다: 호스트 플랫폼

### Flutter vs React Native
#### React Native
자바스크립트를 통해서 운영체제와 대화하고 운영체제는 네이티브 앱에 있는 컴포넌트와 위젯을 만들어낸다
IOS 운영체제에서 쓰이는 위젯을 사용하고 싶다면 React Native를 쓰는 것이 좋음
->하지만 안드로이드에서는 제대로 보이지 않을 것임
버튼을 하나 만들었을 경우 IOS와 안드로이드에서 서로 다르게 보인다
세밀한 디자인 요구사항을 구현하는데 조금 복잡하다
#### Flutter
엔진을 통해서 모든 컴포넌트를 렌더링한다
IOS에서 만든 앱처럼 만들고 싶다면 그런 것처럼 만들 수는 있지만 진짜는 아니다
아주 세밀한 디자인 요구사항이 들어가 있고 요소들이나 애니메이션들을 모두 커스터마이징해야한다면 Flutter를 쓰는 것이 좋다

## 2. Installation

1. SDK 설치(Flutter 설치) : 필수!
2. 시뮬레이터 설치 : 목적에 따라 달라질 수 있음

### SDK 설치
zip파일을 설치해서 path설정
#### windows
chocolatey: windows에 뭔가를 설치할 수 있게 해주는 패키지 매니저
chocolatey 설치(individual)
powershell을 관리자 권한으로 열어준다
설치 과정을 보고 명령어 복붙
choco / choco -? 명령어를 통해 choco가 설치되어있는지 확인
choco install flutter 로 flutter 설치
#### macOs
homebrew 사용


### 시뮬레이터 설치 
무엇을 개발할 것인지 어떤 종류의 시뮬레이터에서 실행시킬건지에 따라서 안드로이드나 IOS또는 macOS의 setup을 따라가면 된다
#### windows
windows, 웹, android
안드로이드 스튜디오 설치 : SDK 설치...
폰과 연결 / 애뮬레이터 실행
-> 설치 과정보고 따라하기

flutter doctor : 컴퓨터에 대한 진단을 나타내준다

## Dart Pad
https://dartpad.dev/ 로 들어가서 Samples > Counter를 눌러서 구동시키면
flutter를 설치하지 않고도 실행시킬 수 있음
but, 다른 파일을 만들 수 있는 방법이 없음
-> 모든 코드가 한 파일에 있어야한다

### Running Flutter
cmd를 관리자 권한으로 연다
flutter 파일을 만들고 싶은 곳으로 들어간다
flutter create [파일명] -> 플러터 파일 생성
cd [파일명]
code . -> vs code로 해당 파일을 열어준다
dart extension을 설치
flutter extension을 설치
-> 밑에 Dart DevTools가 있는지 확인 
lib > main.dart 파일 열기
디버깅해서 확인
Pixel XL 33

### Hello World
모든 위젯들을 기억할 필요는 없다

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// 앱의 root
// 클래스를 위젯으로 만들려면 StatelessWidget을 상속받아야함
class App extends StatelessWidget {
  const App({super.key});

  @override // StatelessWidget을 상속받았기 때문에 해당 메소드를 작성해야함
  Widget build(BuildContext context) {
    return MaterialApp( // named parameter 사용
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello flutter!'), // class의 인스턴스화
        ),
        body: const Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}

```
클래스를 위젯으로 만드려면 flutter SDK에 있는 3개의 core Widget중 하나를 상속받아야한다
(StatelessWidget, StatefulWidget, InheritedWidget)

build 메소드 : Widget의 UI를 만들어주는 역할
-> 위젯을 return해야한다
material : 구글 디자인 시스템(MaterialApp)
cupertino : 애플 디자인 시스템(CupertinoApp)
구글이 flutter를 만들었기 때문에 material 앱 스타일이 훨씬 좋다

Scaffold : 화면의 구조를 제공
class 작성을 끝낼때마다 ,를 찍어주면 예쁘게 정렬된다
