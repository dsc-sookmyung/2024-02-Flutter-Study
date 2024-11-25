## Pomodoro App
### 5.0 User Interface 
**Flexible**   
: 하나의 박스가 얼마나 공간을 차지할지 비율을 정할 수 있음   
높이나 너비가 열마의 픽셀을 가지고 있는지 명확하게 나타나기(하드코딩)보다는   
UI를 비율에 기반해서 더 유연하게 만들 수 있게 해준다   

**Expanded**   
자신이 차지하는 공간보다 더 큰 공간을 차지하게 하고 싶은 경우   
1. container를 row로 감싸준다   
2. container를 또 expanded로 감싼다 (code action으로 widget으로 감싼다고 하고 expanded로 수정하기)   

### 5.1 Timer    
**onStartPressed**  - 버튼이 눌려서 타이머가 시작될 때 호출되는 함수   
:timer 생성(dart의 표준 라이브러리에 포함)   
timer를 통해 정해진 간격에 한번씩 함수를 실행   
사용자가 버튼을 누를때만 타이머가 생성   

onTick를 쓸때 괄호를 넣지 않는 것을 주의   
timer가 해줄거니까 직접 괄호를 써줄 필요없음   
### 5.2 Pause Play 
**onPausePressed** - 버튼이 다시 눌려서 타이머를 멈추게하는 함수   
bool 변수를 만든 다음 타이머가 작동중인지에 따라서 다른 아이콘을 보여줄것임   

각 메소드에서 isRunning bool형 변수로 UI에 반영하도록한다   
만약에 작동을 하고 있으면 -> 정지 버튼   
작동을 하고 있지 않으면 -> 재생버튼   
```dart 
 void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1), // 1초마다 이 함수가 실행됨
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }
```



재생 -> 일시정지 : totalSeconds가 그냥 그대로 놔두어진다   
일시정지 -> 재생 : totalSeconds가 줄어들게 된다   
```dart
 void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }
```

### 5.3 Date Format
```dart
String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }
```
시간을 분과 초로 나오게끔 포맷팅해준다   

만약에 totalSeconds가 0이 되었다면 다시 값을 초기화하고 전체 뽀모도로가 몇번지나갔는지 알려준다   

### 5.4 Code Challenge
타이머를 리셋하는 버튼을 만들고 이에 맞는 메소드 작성    
```dart
void onResetPressed() {
    timer.cancel();
    totalSeconds = twentyFiveMinutes;
    isRunning = false;
    setState(() {});
  }
```
먼저 timer가 더 이상 실행되지 않도록 cancel해준 시간을 초기화해주었다.   
그리고 더 이상 실행중이지 않는다는 것을 bool로 만들어서 setState로 build 해주게끔 실현했다.    


### 전체 코드 
```dart
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes; // 25분을 초로 환산한 값
  bool isRunning = false;
  // late - 해당 property를 당장 초기화하지 않아도 된다
  late Timer timer;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  // 타이머 초기화
  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1), // 1초마다 이 함수가 실행됨
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  // code challenge
  void onResetPressed() {
    timer.cancel();
    totalSeconds = twentyFiveMinutes;
    isRunning = false;
    setState(() {});
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                  ),
                ),
                // code challenge
                Center(
                  child: IconButton(
                    iconSize: 50,
                    color: Theme.of(context).cardColor,
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.radio_button_checked),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          ('$totalPomodoros'),
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```
