## api 활용해보기
### 6.10 Hero   
: 화면을 전환할 때 멋진 애니메이션을 제공   
각각의 위젯에 같은 태그(id)를 준다
webtoon_widget.dart와 detail_screen.dart에 각각   
Container를 Hero로 감싸주고 tag에 id값을 정의해준다   
fullscreenDialog 설정을 삭제해도 동일하게 적용된다   
#### widgets > webtoon_widget.dart
```dart
Hero(
            tag: id,	// 태그 추가
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                thumb,
                headers: const {
                  'User-Agent':
                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                  'Referer': 'https://comic.naver.com',
                },
              ),
            ),
          ),
```
#### screens > detail_screen.dart
```dart
Hero(
                tag: widget.id,		// 태그 추가
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  child: Image.network(
                    widget.thumb,
                    headers: const {
                      'User-Agent':
                          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                      'Referer': 'https://comic.naver.com',
                    },
                  ),
                ),
              ),
```
웹툰 위젯을 선택했을 경우, detail screen에서 사진이 슬라이딩해서 가운데로 온다(애니메이션)


### 6.11 Recap
MaterialPageRoute는 이 모든 애니메이션을 생성하는 역할을 한다   
핵심: 애니메이션을 통해서 사용자가 다른 화면으로 간다고 느끼게 만든다는 것   
실은 새로운 stateless widget을 렌더링하는 것 뿐이다   
Hero: 두 화면 사이에 애니메이션을 주는 컴포넌트   


### 6.12 ApiService
**model > webtoon_model.dart **
: title, thumb, id

**models > webtoon_detail_model.dart**
: title, about, genre, age, thumb
```dart
class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
```

**models > webtoon_episode_model.dart**
: id, title, rating, date
```dart
class WebtoonEpisodeModel {
  final String id, title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
```
#### api_service.dart
**getToonById**   
: id로 웹툰의 정보를 가져온다
```dart
static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }
```

**getLatestEpisodesById**   
: id로 최신 에피소드를 가져온다
```dart
static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
```


### 6.13 Futures
**DetailScreen**   
getLatestEpisodesById와 getToonById 호출

다른 property인 id에 대한 접근 필요 -> 오류   
id를 바로 불러올 수 없음   

<해결책>   
Convert to StatefulWidget   
이렇게 하는 순간 title이 아니라 widget.title이런식으로 바뀐다   
별개의 class로 나뉘어서 접근하고 싶은 필드 앞에 widget이 붙는다   
ex) widget.title, widget.about   
cf) stateless widget일 경우엔 그냥 쓰면 된다   

```dart
Future<WebtoonDetailModel> webtoon = ApiService.getToonById(widget.id); // 아직도 오류
```
오류 이유: State 객체가 생성되기 전에 widget에 접근하려고 시도하기 때문   
생성자에서 widget이 참조될 수 없다   
:StatefulWidget 생성자에서는 State 객체가 초기화되기 전이라 widget 속성에 접근할 수 없다는 뜻   
>**StatefulWidget의 생명주기 흐름**
>1. StatefulWidget 생성
title같은 속성값이 초기화됨
>2. State 객체 생성
StatefulWidget의 데이터를 사용할 수 있는 widget 속성이 연결됨
>3. initState 호출
widget 데이터를 안전하게 사용가능
>4. build 호출
UI 렌더링

```dart
late Future<WebtoonDetailModel> webtoon; // 이렇게 변경
```
나중에 정의해준다는 표시

**late**
: 초기화를 하고 싶지만 생성자에서 불가능한 경우 함수(initState)에서 초기화
initState는 build보다 먼저, 단 한 번 호출된다
```dart
 @override
  void initState() {
    super.initState();
    // webtoon(Future) 초기화
    webtoon = ApiService.getToonById(widget.id);
    // episodes(Future) 초기화
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

```
그러므로 이제 FutureBuilder에 쓸 수 있다

HomeScreen과 비교
>**HomeScreen**   
Future를 바로 초기화 가능   
Future가 따로 argument를 요구하지 않았기 때문   
**DetailScreen**   
사용자가 클릭한 웹툰의 id를 받아야하기 때문에 바로 초기화 불가   
  
### 6.14 Detail Info

**최종 코드**
```dart
import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon_detail_model.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/models/webtoon_episode_model.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    // 비동기적으로 데이터를 가져온다
    // webtoon(Future) 초기화
    webtoon = ApiService.getToonById(widget.id);
    // episodes(Future) 초기화
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  child: Image.network(
                    widget.thumb,
                    headers: const {
                      'User-Agent':
                          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                      'Referer': 'https://comic.naver.com',
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Text("...");
            },
          ),
        ],
      ),
    );
  }
}
```
>**StatefulWidget**
- 비동기 작업의 상태를 State에서 관리한다
- 상태에 따라 렌더링되는 값이 달라진다
- initState에서 Future을 초기화하고 필요시 setState를 통해 상태를 변경하며 UI를 갱신한다
  
  ![](https://velog.velcdn.com/images/chesunny/post/33cd98cb-7ac0-492a-a09e-6894a790a191/image.png)

