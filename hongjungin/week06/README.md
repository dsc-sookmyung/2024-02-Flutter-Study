
## 코드 설명

```dart
String format(int seconds) {
  var duration = Duration(seconds: seconds);
  return duration.toString().split(".").first.substring(2, 7);
}
```

- `Duration` 클래스를 사용해 시간 포맷팅.
- `.split()`과 `.substring()`을 통해 포맷을 정리.


```dart
void onStartPressed() {
  timer = Timer.periodic(
    const Duration(seconds: 1),  // 1초 간격으로
    onTick,  // 매초 onTick 호출
  );
  setState(() {
    isRunning = true;  
  });
}
```


- `Timer.periodic` 을 사용하여 일정 간격으로 작업 수행.
- `setState`로 UI 갱신.

```dart
void onPausePressed() {
  timer.cancel();  // 타이머 취소
  setState(() {
    isRunning = false;  // 타이머 중지
  });
}
```

- `timer.cancel()`을 통해 주기적인 호출 중단.

```dart
void onTick(Timer timer) {
  if (totalSeconds == 0) {
    setState(() {
      totalPomodoros += 1;  // 뽀모도로 횟수 증가
      totalSeconds = twentyFiveMinutes;  // 타이머 리셋
    });
    timer.cancel();  // 타이머 중지
  } else {
    setState(() {
      totalSeconds -= 1;  // 1초씩 차감
    });
  }
}
```

## 코드 챌린지

```dart
void onRestartPressed() {
  timer.cancel();  // 타이머 취소
  setState(() {
    totalSeconds = twentyFiveMinutes;  // 시간을 초기화
    isRunning = false;  // 실행 상태 초기화
  });
}
```

```dart
IconButton(
  iconSize: 120,
  color: Theme.of(context).cardColor,
  onPressed: isRunning ? onPausePressed : onStartPressed,
  icon: Icon(
    isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline,
  ),
)
```

- `isRunning` 값에 따라 버튼 동작과 아이콘이 동적으로 변경됨.



```
Flexible(
  flex: 1,
  child: Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: Column( 
          ),
        ),
      ),
    ],
  ),
),

```


- `Flexible`과 `Expanded`를 사용하여 화면 비율 조정.
- `Container`로 각 섹션의 UI 정의.
- `flex` 속성을 통해 레이아웃 비율을 조정.
- `BoxDecoration`을 통해 디자인 요소 추가.


















