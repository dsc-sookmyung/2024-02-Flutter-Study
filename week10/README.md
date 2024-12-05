## url Launcher 사용해보기
### 6.15 Episodes 

에피소드 리스트를 마크업 
### 6.16 Url Launcher

해당 에피소드 위젯을 누르면 해당 회차의 에피소드가 열리게끔 url을 연결해준다
>**url_launcher 패키지 설치**
pub.dev > url_launcher 검색하면 설치 방법중 택 1
> 
>1. 터미널에 밑의 코드 입력하여 설치   
flutter pub add url_launcher   
>2. configuration 파일 추가 설정   
ios: pub.dev에서 info.plist에 추가   
android: pub.dev에서 xml을 AndroidManifest.xml에 추가   
(android > app > src > main > AndroidManifest.xml)   


나는 안드로이드를 사용하였다
manifest안에 해당 코드 추가
```javascript
	<queries>
      <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
      </intent>
    </queries>
```

hot reloading: dart 코드 변경만 감지   
configuration 파일수정: hot reloading아님 멈춤을 누르고 다시 main으로 다서 디버깅 눌러준다   

url을 따로 정의하고 launchUrl 호출
```dart
 onButtonTap() async {
    final url = Uri.parse("https://google.com");
    // Future 반환
    await launchUrl(url);
  }
```

한 번에 launchUrlString 호출해서 url에 접속
```dart
onButtonTap() async {
    await launchUrlString("https://google.com");
  }
```

**widgets > episode_widget.dart**
```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon_app/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    // 추가적으로 선택된 웹툰의 id를 가져온다
    required this.webtoonId,
  });

  final WebtoonEpisodeModel episode;
  final String webtoonId;
  
	// 해당 위젯이 눌렸을 때 처리하는 메소드 
  onButtonTap() async {
  	// url로 접속 
   // comic.naver.com/webtoon/detail/웹툰의 아이디&에피소드의 번호(id)
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    // 에피소드 위젯을 클릭한 경우 url로 연결
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade400,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

```

### 6.17 Favorites
하트가 눌렸을 때, 이벤트 처리   
: 좋아요가 눌리고 한번 더 누르면 좋아요가 취소되게끔 한다

shared_preferences 패키지   
:핸드폰 저장소와 connection을 만들어서 다양한 데이터를 다른 자료형으로 저장 가능   
-> 핸드폰 저장소에 좋아요 여부 저장

pub.dev > shared_preferences 검색하면 설치 방법중 택 1   
터미널에 밑의 코드 입력하여 설치   
flutter pub add shared_preferences 

**screens > detail_screen.dart 완성 코드**
```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoon_app/models/webtoon_detail_model.dart';
import 'package:webtoon_app/models/webtoon_episode_model.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widgets/episode_widget.dart';

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
  late SharedPreferences prefs;
  bool isLiked = false;

// 사용자의 저장소에 connection 생성
  Future initPrefs() async {
    // 핸드폰 저장소에 access를 얻는다
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    // likedToons 리스트가 존재하는 경우
    if (likedToons != null) {
      // 사용자가 해당 좋아요를 누른 적이 있는 경우
      if (likedToons.contains(widget.id) == true) {
      	// UI 반영 - 예전에 저장소에 있는 값 반영되게끔
        setState(() {
          isLiked = true;
        });
      }
      // likedToons 리스트가 존재하지 않는 경우 (초기)
    } else {
      // likedToons 리스트를 생성해준다
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    // webtoon(Future) 초기화
    webtoon = ApiService.getToonById(widget.id);
    // episodes(Future) 초기화
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

	// 좋아요가 눌렸을 경우 해당 이벤트 처리
  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    //
    if (likedToons != null) {
      // 좋아요가 눌러져 있는 경우에 클릭하면
      if (isLiked) {
        // 좋아요 리스트에서 뺀다 (좋아요 취소)
        likedToons.remove(widget.id);
        // 좋아요 눌러져 있지 않은 경우에 클릭하면
      } else {
        // 좋아요 리스트에 추가한다 (좋아요 추가)
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        // 하트 누르기 기능 추가 
        actions: [
        	// 좋아요가 눌렸을 경우 해당 이벤트 처리
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          )
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
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
                      child: Image.network(widget.thumb, headers: const {
                        'Referer': 'https://comic.naver.com',
                      }, errorBuilder: (context, error, stackTrace) {
                        return const Text('이미지를 불러올 수 없습니다.');
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
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
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                      // 10개의 에피소드만 추가되도록한다
                        for (var episode in snapshot.data!.length > 10
                            ? snapshot.data!.sublist(0, 10)
                            : snapshot.data!)
                            // webtoonId 추가적으로 episode에 보내준다
                          Episode(episode: episode, webtoonId: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

- 좋아요 기능 추가, 에피소드 리스트 추가   
![](https://velog.velcdn.com/images/chesunny/post/5a30aa68-c1ab-42b1-bfb7-606c4cc23fd4/image.png)

- 에피소드 url 접속   
![](https://velog.velcdn.com/images/chesunny/post/c81fbdbc-9a5c-4336-8f68-a5cb8409c854/image.png)   

>- 에피소드 리스트 추가
>- 에피소드 위젯 선택시 url접속 기능 추가
>- 좋아요 기능 추가
