# 3주차: 	Flutter 간단하게 살펴보기
<strong>Flutter로 웹툰 앱 만들기 #1 #2 정리</strong><br>
<strong>Flutter 개발환경 세팅하기</strong><br><br>
웹, ios, 안드로이드, 맥 os, 윈도우, 리눅스, 임베디드 디바이스에서 작동하는 app을 <strong>flutter</strong>로 한번에 만들 수 있다. 알리바바, 틱톡, 구글페이 등 많은 거대 기업들이  <strong>flutter</strong>기반으로 서비스를 제공한다. <strong>flutter</strong>는 성장하는 플랫폼이 아닌 이미 신뢰받고 있는 플랫폼이다. <br><br><img width="383" alt="flutter architectural" src="https://github.com/user-attachments/assets/c80cf9ca-58b6-4a23-b5eb-22121aaa96d4"><br><br>
native framework : 운영체제와 직접 소통하고 운영체제가 직접 UI 렌더링.<br>
flutter : 자체 engine 이용하여 UI 렌더링. <br><br>
<strong>flutter</strong>에서는 전부 렌더링 엔진에 의해 UI를 구성한다. 그러므로 <strong>flutter</strong>을 이용해 통제할 수 있는 요소가 많아진다. (운영체제과 관계 없기 때문에) <br><br>
<strong>flutter</strong>에서는 네이티브에서 사용 가능한 위젯을 사용할 수 없다. -> 부자연스러움 <br><br>
<strong>세밀한 디자인 요구사항이 있거나, 요소들과 애니메이션 모두 커스터마이징 하고싶다면 flutter 가 적합하다. </strong><Br><Br>
embedder : <strong>flutter</strong>엔진을 가동시킨다. 호스트플랫폼 (ios, android, window...) 상에서 엔진 가동할 수 있도록 도와준다. <br><br>
### flutter 개발환경 세팅
<img width="607" alt="flutter setting" src="https://github.com/user-attachments/assets/b5a9f65b-c989-44ed-97f9-6a9210bf3824">
chocolatey 이용하여 flutter 한번에 다운<br>
android studio 설치 후 가상 device 설치.<br>
<sup><strong>설치 시 경로에 한글이나 특수문자가 들어가 실행 시 오류가 발생했다. C:에 저장하는 것이 가장 좋다. </strong></sup><br><br><br>

```
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello flutter'),
        ),
        body: Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}
```
<ul>
  <li><code>runApp(App());</code>은 앞으로 만들 앱의 root가 되는 지점이다.</li>
  <li>widget을 사용하기 위해 class 선언후 <code>StatelessWidget</code>상속받는다.</li>
  <ul>
    <li>가장 기본적인 widget. 무언가를 화면에 띄우기 위한 widget</li>
  </ul>
  <li><code>Widget build()</code> -> 디자인 하기 위한 set을 반환해야한다.</li>
  <ul>
    <li><code>MaterialApp</code> : google style design</li>
    <li><code>CupertinoApp</code> : ios style design</li>
  </ul>
  <li><code>home</code> : widget 반환해야한다. -> <code>Scaffold</code></li>
  <li><code>Scaffold</code> : app을 구조적으로 디자인 -> <code>appBar</code>,<code>body</code></li>
  <li><code>appBar</code>의 <code>title</code>은 <code>text</code>widget 반환한다. </li>
  <li><code>body</code>의 <code>Center</code>은 <code>text</code>widget 반환한다.</li>
</ul>
<br>
<img width="1280" alt="화면 캡처 2024-10-14 000103" src="https://github.com/user-attachments/assets/a43cd06e-4619-4100-8a3c-c6fa75982671">
<br><br>
