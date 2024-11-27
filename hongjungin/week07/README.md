 ## 6.1 AppBar

 `AppBar`는 앱 상단의 기본 네비게이션 영역을 정의.

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

- `elevation`: AppBar의 입체감을 제어하며, 2로 설정하여 약간의 그림자 효과를 남김.

<br></br>

-------------------------------

## 6.2 Data Fetching

비동기 요청의 필요성

- 서버에 요청을 보낼 때 네트워크 상태, 서버 부하 등으로 인해 시간이 걸릴 수 있으므로 비동기 처리학 필요하다.
- `await` 를  사용하여 서버 응답이 올 때까지 프로그램을 대기하게 만듦.
- 비동기 함수는 반드시 `async` 키워드를 추가해야 하며, 반환 타입은 `Future<T>` 형태로 지정한다.

<br></br>

---------------------------------------

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
```
1. API 요청 : 

  - `http.get(url)`을 사용해 GET 요청을 보낸다.
  - 응답 코드는 `response.statusCode`로 확인하며, 200일 경우 성공으로 간주

2. JSON 처리 :

   - `jsonDecode` : 응답 본문을 JSON 형식으로 변환.
   - 변환된 데이터를 `WebtoonModel` 객체로 매핑 후 리스트에 추가.
  

3. 비동기 함수 :

   - 반환 타입은 `Future<List<WebtoonModel>>`로, 서버에서 받아올 데이터를 리스트로 반환.


<br></br>

-------------------


## fromJson

서버에서 받은 JSON 데이터를 WebtoonModel 클래스 객체로 변환

```dart
class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
```

- `Named Constructor` :
    - JSON 데이터를 간편하게 변환할 수 있어 코드의 가독성과 간결성을 높인다.
    - 각 속성은 JSON 키 `(json['key'])`를 기반으로 초기화.
 

<br></br>

-----------------------------------

## Data Fetch 요약

1. API 요청 흐름 :

  - API에 GET 요청을 보냄 -> JSON 응답을 받음 -> Dart 객체로 반환 -> 리스트로 저장.

2. WebtoonModel :

   - 데이터를 다루기 쉽게 `title` `thumb` `id` 속성을 가진 객체로 변환
   - 모든 API 호출은 `ApiService` 에서 처리하여 깔끔하게 유지한다.




