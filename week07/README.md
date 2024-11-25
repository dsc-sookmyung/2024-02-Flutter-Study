## Data Fetch 이해하기
### 6.1 AppBar

lib > screens > home_screen.dart
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
```
따로 코드를 빼내서 정의하였음
### 6.2 Data Fetching
https://pub.dev/ : 다트, 플러터 공식 패키지 보관소

#### http 패키지 다운받는 다양한 방법 
http 패키지: http 요청을 만들때 구성이 편한 라이브러리임

1. cmd에
dart pub add http 혹은 flutter pub add http 입력

2. C:\GDG_Flutter\flutter_projects\webtoon_app\pubspec.yaml에
dependencies:
	http: ^0.13.5
추가 후 저장

이 파일은 프로젝트에 대한 정보를가지고 있음
프로젝트에 대한 정보와 설정이 담김

#### get 요청 후 response 처리
해당 url로부터 get 요청을 통해 response를 받아옴   
하지만 서버로부터 response를 받을 때,   
유저 네트워크 문제 혹은 서버의 메모리 문제로 오랜 시간이 걸릴 수 있으므로 요청이 처리되는데 오랜 시간이 걸릴 수 있음   
-> 서버가 응답할때까지 프로그램을 기다리게끔한다(await를 사용)   
비동기함수내에서만 사용될수 있으며 클래스명 뒤에 async를 써줘야됨   

Future 타입을 이용해서 현재가 아닌 받을 결과값의 타입을 제네릭에 설정한다.   

lib > services > api_service.dart
```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon_model.dart';

//flutter위젯이나 클래스가 아닌 평범한 다트클래스
class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // api에 요청을 할 수 있었으면 좋겠음
  // 그리고 pai가 반환한 json을 내 콘솔에 프린트하도록한다

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
    	// string -> json -> List<dynamic>
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // final toon = WebtoonModel.fromJson(webtoon);
        // print(toon.title);
        // dynamic -> WebtoonModel 객체 
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
```
### 6.3 fromJson
서버로부터 받는 이 제이슨 형식의 데이터를 다트언어와 플러터에서 쓸수 있는 데이터형식인 클래스로 바꿔줘야됨

models > webtoon_model.dart
WebToonModel 객체 생성
```dart
class WebtoonModel {
  final String title, thumb, id;

  // named constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
```

### 6.4 Recap

기본 constructor를 쓴 형태
```dart
class WebtoonModel {
  late final String title, thumb, id;

  WebtoonModel({
    required this.title,
    required this.thumb,
    required this.id,
  });
}
```
late: 값을 할당하지 않은 상태로 인스턴스 생성 가능,   
인스턴스 생성된 후에도 값 변경 가능   
named constructor가 더 보기 좋음   
: constructor의 인수만 적어주고 property를 적어주면 초기화할 수 있어서 매우 편리함   

> 요약:
api 요청을 보내고 json을 받음
그리고 형변환을 통해 객체에 넣어서 리스트로 모았음
![](https://velog.velcdn.com/images/chesunny/post/946e37a4-60ff-4994-a4ac-9e3ab49e8fd3/image.png)
--> data들이 fetch된 것을 확인할 수 있다. 
