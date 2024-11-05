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

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //스타일 지정 방법
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 209, 92),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                  onPressed: toggleTitle,
                  icon: const Icon(Icons.remove_red_eye))
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
  /*InitState는 상태를 초기화 하는 메서드이다 , 필수는 아니다.
  항상 build 메서드 보다 먼저 출력되야하고 단 한번만 호출된다.*/
  int count = 0;
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  /*위젯이 스크린에서 제거될 때 호출하는 메소드이다.
  API 업데이트, 이벤트 리스너로 부터 구독 취소, form의 리스터로부터 벗어날 때 (=위젯이 위젯트리에서 삭제되기 전에 무언가를 취소 한다)*/
  @override
  void dispose() {
    super.dispose();
    print("dispose!");
  }

  @override
  Widget build(BuildContext context) {
    print('build!');
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge!.color, //! 무조건 ? 있으면 써
      ),
    );
  }
}
