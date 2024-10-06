# 2주차: 비동기 프로그래밍 알아보기
<strong>Dart #4 Async Programming 비동기 프로그래밍 강의 내용 정리</strong><br><br>
thread는 cpu작업의 가장 작은 단위로 하나의 thread가 작업 완료 되기 전까지 cpu사용이 불가하다.<br>
thread 처리 중 서버 요청 시 cpu는 사용되지 않지만 다른 thread가 cpu사용할 수 없는 문제가 발생한다.<br>
<em>cpu를 효율적으로 사용하기 위해 async 비동기 프로그래밍 기법을 사용한다. </em><br>
---> async : 작업1 실행 > 작업1 서버요청 > cpu 사용 가능 > 작업 2 실행 > 작업 1 완료 > 작업 1 완료<br><br>
<strong>일반적인 경우</strong>
```
void main() {
  addNumbers(1,1); 
  addNumbers(2,2);
}

void addNumbers(int number1, int number2){
  print('계산중: $number1 + $number2');
  print('계산 완료: ${number1+number2}');
}
```
<code>addNumbers(1,1)</code>를 실행 한 후 결과 출력, 그 후 <code>addNumbers(2,2)</code> 가 실행되고 결과가 출력된다. <br><br>
<strong>Future - delayed</strong>
```
void main() {
  //Future
  //미래에 받아올 값
  addNumbers(1,1);
  addNumbers(2,2);
}

void addNumbers(int number1, int number2){
  print('계산 시작 : $number1 + $number2');
  //서버 시뮬레이션
  //2개의 파라미터
  //delayed
  //1번 파라미터 - 지연할 기간
  //2번 파라미터 - 지연 후 실행 함수
  Future.delayed(Duration(seconds:2),(){
    print('계산 완료 : $number1 + $number2 = ${number1+number2}');
  });
  print('함수 완료 : $number1 + $number2');
}
```
<code>Future</code>, <code>delayed</code> 사용하여 비동기 프로그래밍 구현이 가능하다.<br>
<code>delayed</code>는 파라미터 2개를 필요로 한다. (1번:지연할 시간, 2번:지연 후 실행할 함수)<br>
위의 코드의 출력 결과는 아래와 같다. <code>delayed</code>가 <code>계산 완료</code>에만 적용되어있기 때문에 2초 대기 후 출력된다. 
```
계산 시작 : 1 + 1
함수 완료 : 1 + 1
계산 시작 : 2 + 2
함수 완료 : 2 + 2
계산 완료 : 1 + 1 = 2
계산 완료 : 2 + 2 = 4
```
<br><br>
<strong>async - await</strong>
```
void main() {
  
  addNumbers(1,1);
  addNumbers(2,2);
}

void addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');
  //서버 시뮬레이션
  await Future.delayed(Duration(seconds:2),(){
    print('계산 완료 : $number1 + $number2 = ${number1+number2}');
  });
  print('함수 완료 : $number1 + $number2');
}
```
<code>await</code>기능을 이용하면 논리적 대기 상태를 만들 수 있다. 해당 코드 실행 결과는 아래와 같다.
```
계산 시작 : 1 + 1
계산 시작 : 2 + 2
계산 완료 : 1 + 1 = 2
함수 완료 : 1 + 1
계산 완료 : 2 + 2 = 4
함수 완료 : 2 + 2
```
<code>delayed</code>만을 사용하면 <code>delayed</code> 아래에 있는 명령어가 먼저 실행되지만 <code>await</code>를 사용하면 <code>delayed</code> 아래에 있는 명령어는 <code>delayed</code>가 실행이 끝날때 까지 대기하고 그 후 실행되게 된다. <br>
실행 결과를 보면 <code>계산 시작 : 1 + 1</code>후 <code>계산 시작 : 2 + 2</code>가 출력됨을 알 수 있다. <code>await</code>동안 cpu가 <code>addNumbers(2,2)</code>를 실행했음을 알 수 있다 ---> async programming

```
void main() async {
  
  // await addNumbers(1,1); 오류 : Future을 리턴 안함
  // addNumbers(2,2);
}

void addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');
  //서버 시뮬레이션
  await Future.delayed(Duration(seconds:2),(){
    print('계산 완료 : $number1 + $number2 = ${number1+number2}');
  });
  print('함수 완료 : $number1 + $number2');
}
```
해당 코드는 오류가 발생한다. <code>await</code>는 <code>Future</code>만 리턴이 가능하다. 따라서 아래와 같이 코드를 수정해야한다. 
```
void main() async {
  
  await addNumbers(1,1); 
  await addNumbers(2,2);
}

Future<void> addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');
  //서버 시뮬레이션
  await Future.delayed(Duration(seconds:2),(){
    print('계산 완료 : $number1 + $number2 = ${number1+number2}');
  });
  print('함수 완료 : $number1 + $number2');
}
```
<code>await</code>는 모든 함수에서 사용이 가능하지만 함수와 { 사이에 <code>async</code>를 추가하고 <code>Future</code>을 리턴하도록 수정해야한다. <br>
```
void main() async {
  
  final result1 = await addNumbers(1,1); 
  final result2 = await addNumbers(2,2);
  
  print('result1 : $result1');
  print('result2 : $result2');
  print('result1 + result2 = ${result1+result2}');
}

Future<int> addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');
  //서버 시뮬레이션
  await Future.delayed(Duration(seconds:2),(){
    print('계산 완료 : $number1 + $number2 = ${number1+number2}');
  });
  print('함수 완료 : $number1 + $number2');
  
  return number1+number2;
}
```

위의 코드처럼 Future 함수를 실행하여 리턴된 값을 변수로 선언이 가능하다. <br><br><br>
<strong>stream</strong><br>
<code>await</code> : 논리적 대기 구현 가능<br>
<code>Future</code> : 함수 1 ---> 반환값 1 <br>
<code>stream</code> : 함수 1 ---> 반환값 n (직접 닫기 전까지 무한대로 생성 가능) <br>

```
import 'dart:async';

void main(){
  final controller = StreamController();
  final stream = controller.stream;
  
  final streamListener1 = stream.listen((val){
    print('Listener 1 : $val');
  });
  
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.sink.add(5);
 
}
```

<code>controller</code>에서 선언한 값들을 <code>listener</code>를 이용하여 1개의 <code>listen</code>에 대해 여러번의 반환이 가능하다. <br>

```
import 'dart:async';

void main(){
  final controller = StreamController();
  final stream = controller.stream.asBroadcastStream();
  
  final streamListener1 = stream.where((val)=>val%2==0).listen((val){
    print('Listener 1 : $val');
  });
  
  final streamLintener2 = stream.where((val)=>val%2==1).listen((val){
    print('Lintener 2 : $val');
  });
  
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
  controller.sink.add(5);
 
}
```

<code>.asBroadcastStream</code> 를 붙이면 하나의 컨트롤러에서 받는 값을 여러개의 리스너에서 사용이 가능하다. 또한 where, reduce, fold 등을 이용한 함수형 프로그래밍도 가능하다. <br>

```
import 'dart:async';

void main(){
  calculate(2).listen((val){
    print('calculate(2) : $val');
  });
  calculate(4).listen((val){
    print('calculate(4) : $val');
  });
}

Stream<int> calculate(int number) async* {
  for(int i=0; i<5; i++){
    yield i*number;
    
    await Future.delayed(Duration(seconds:1));
  }
}
```

<code>stream</code> 반환으로 비동기적으로 값을 계속 전달하며 <code>yield</code>를 이용하여 호출될 때 마다 값을 하나씩 전달하고 일시 중단한다. 해당 코드의 실행 결과는 아래와 같다.

```
calculate(2) : 0
calculate(4) : 0
calculate(2) : 2
calculate(4) : 4
calculate(2) : 4
calculate(4) : 8
calculate(2) : 6
calculate(4) : 12
calculate(2) : 8
calculate(4) : 16
```

만약 <code>calculate(2)</code>와 <code>calculate(4)</code>를 따로따로 실행하고 싶다면 <code>calculate</code>앞에 <code>yield*</code>를 붙여주면 됟다.

```
import 'dart:async';

void main(){
  playAllStream().listen((val){
    print(val);
  });
}
Stream<int> playAllStream() async* {
  yield* calculate(1); //yield* 모든 값 가져올때 까지 대기
  yield* calculate(1000);
}

Stream<int> calculate(int number) async* {
  for(int i=0; i<5; i++){
    yield i*number;
    
    await Future.delayed(Duration(seconds:1));
  }
}
```

위의 코드는 <code>yield*</code>를 붙여주었기 때문에 <code>calculate(1)</code> 실행 후 <code>calculate(1)</code>를 실행한다. 결과는 아래와 같다.

```
0
1
2
3
4
0
1000
2000
3000
4000
```
