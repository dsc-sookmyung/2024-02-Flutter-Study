### 6.5 waitForWebToons
future 데이터를 불러와서 보여주는 방법은 두가지!
1. homescreen widget을 statefulwidegt으로 변경
``` dart
import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    // 비동기 함수 - http 요청을 기다리는 함수를 기다려야함
    webtoons = await ApiService.getTodaysToon();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
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
HomeScreen에 있는 클래스에서 initState()를 통해서 이 클래스가 시작될때, getTodaysToons에서 response가 들어오는것을 waitForWebToons로 기다려서 response를 받고 시작하도록한다
await, setState(), isLoading으로 조작

### 6.6 FutureBuilder
 2. StatelessWidget에서 FutureBuilder 사용해서 fetch
```dart
final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();
```
webtoons를 출력해보면 Future이 그대로 찍혀 기다리고 있지 않은 것을 확인할 수 있다. 
--> FutureBuilder를 이용해서 해결! (기다려주고 받은 값을 builder에 구현)
: Future 타입의 값을 만들고 이를 FutureBuilder의 future에 넣기만 하면 해결된다
```dart
FutureBuilder(
		// future: 기다릴 대상 - 자동으로 await가 들어간다
        future: webtoons,
        // builder: ui를 그려주는 함수
        // context - BuildContext
        // snapshot - future의 상태를 알려준다
        builder: (context, snapshot) {
        // future에 데이터가 들어왔을 경우
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          // 데이터를 아직 받지 못한 경우 (로딩)
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
```
### 6.7 ListView
많은 양의 데이터를 연속적으로 보여주고 싶을때 사용
snapshot의 데이터는 future의 결과값임 

webtoon_model > WebtoonModel: 리스트에 넣어주기 위한 객체
webtoon_widget.dart > Webtoon: 출력하기 위한 웹툰 위젯

ListView를 쓰는 다양한 방법
1. ListView
2. ListView.builder
3. ListView.separated

1. ListView
많은 양의 데이터를 연속적으로 보여주고 싶을때 사용
가장 기본형
```dart
 body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var webtoon in snapshot.data!) Text(webtoon.title)
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
```
리스트에 있는 모든 아이템들을 한번에 로딩하고 있음
문제점: sns같은 경우, 타임라인에 있는 모든 사진을 한번에 로딩하면 메모리를 너무 많이 사용하게 될 것임
--> 사용자가 보고잇는 사진이나 섹션만 로딩(ListView 사용)


2. ListView.builder
최적화된 ListView
사용자가 보고 있는 아이템만 build하고 보고 있지 않다면 메모리에서 삭제하도록한다
어떤 아이템이 build 되는지 인덱스를 통해 알 수 있다

> 속성
scrollDirection: 스크롤방향을 정할 수 있음
itemCount: 리스트의 아이템 개수를 설정할 수 잇음
--> 다트가 몇 개의 아이템을 build할건지 알게된다
itemBuilder: 리스트의 특정 UI만 build하도록 한다
context와 index(생성되는 객체의 index)를 매개변수로 주고 출력할 것을 반환한다

```dart
return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index);
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
            );
```
3. ListView.separated

> 속성
separatorBuilder: 리스트 아이템 사이에 렌더링되는 위젯을 반환
(ListView.builder에 더해 추가적인 속성)

screens > home_screen.dart 의 최종 코드
```dart
import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';
import 'package:webtoon_app/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();
  // 클래스에 Future을 넣었으니 Homescreen앞에 있던 const를 삭제해줘야함

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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
```

### 6.8(Webtoon Card)
widgets > webtoon_widget.dart
```dart
import 'package:flutter/material.dart';
import 'package:webtoon_app/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
	// WebtoonModel로부터 가져오는 방법도 있다
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
  	// 사용자의 이벤트 처리해주는 함수
    return GestureDetector(
    	// 클릭했을 경우
      onTap: () {
        Navigator.push(
          context,	// buildcontext
          MaterialPageRoute(	//route
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
                 // 화면의 위젯을 전환하는 애니메이션 효과
                // 이미지를 바닥에서부터 가져오게끔 한다 
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
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
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
```

> - BoxDecoration 속성
borderRadius: 컨테이너의 테두리 둥글게 만들어준다

>- boxShadow: BoxShadow 속성
그림자의 속성을 정의
bluredRadius: 그림자 길이
offset: 그림자 위치
(0, 0)은 정확히 가운데를 뜻한다
color: 그림자 색깔 (디폴트 색상: 빨간색)

![](https://velog.velcdn.com/images/chesunny/post/f2d29f67-e33a-47ac-aa81-07d6f061578b/image.png)


### 6.9 Detail Screen
**DetailScreen**
스크린처럼 보이지만 그저 StatelessWidget이다 (단순한 위젯임)

GestureDetector : 사용자가 웹툰을 탭했을때 사용자를 그 페이지로 보낼 수 있도록 그 이벤트의 발생을 감지하도록한다

```dart
onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: true,
          ),
        );
      },
```

onTap: 버튼을 탭 했을때 발생하는 이벤트이다
- onTapDown: 손가락이 내려왔다는 것을 의미
- onTapUp: 손가락을 들엇다는 것을 의미한다
-> 유저를 다른화면으로 보내기 전에 새로운 화면을 만든다 (DetailScreen으로 이동)

Navigator.push()의 매개변수
- context: BuildContext 상위 컴포넌트에 접근할 수 있게 한다
- route : MaterialPageRoute나 CupertinoPageRoute
-> detailScreen 같은 statelessWidget을 애니메이션 효과로 감싸서 스크린처럼 보이게 한다 

>route의 옵션
>- 이미지를 바닥에서부터 가져오도록 한다
fullscreenDialog: true
--> 돌아가기 버튼은 X로 설정된다 
>- 옆에서부터 이미지를 가져오도록 한다
fullscreenDialog: false
--> 돌아가기 버튼은 뒤로가기로 설정


아이콘은 (foregroundColor)색깔을 반영

해당 웹툰 위젯을 클릭했을 때 보이는 스크린
screens > detail_screen.dart
```dart
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          title,
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
              Container(
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
            ],
          ),
        ],
      ),
    );
  }
}
```
![](https://velog.velcdn.com/images/chesunny/post/7c00f8fb-521a-4a8c-9847-f95bccc49b59/image.png)
