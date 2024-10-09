# 4. 비동기 프로그래밍(Asynchronous Programming)
* 동기 프로그래밍   
: CPU가 하나의 작업을 하고 있을 경우, 다른 작업을 하지못함   
--> 코드 순서대로 실행됨   
* 비동기 프로그래밍   
:CPU가 하나의 작업이 끝날 때까지 기다리는 동안 다른 작업을 할 수 있음   
--> 코드 순서대로 실행되지 않음   
## 4.1 비동기 프로그래밍(Asynchronous Programming)
* Future : 미래에 받아올 값 → 제네릭에 미래에 받아올 타입을 지정   
ex) Future<String> name = Future.value('코드팩토리');
비동기적으로 실행
* await, async   
비동기로 실행되는 곳에서 동기적으로 순서대로 실행하게끔 함   
Future를 리턴하는 곳에서 사용가능함   
await를 사용하기 위해 async를 함수정의시, 매개변수 뒤에 작성   
--> 함수를 호출하는 경우에도 동기적으로 실행하게끔하려면   
main함수에도 다른 함수들처럼 async을 작성해줌
## 4.2 스트링(Stream)
import 'dart:async'; 를 통해서 필요한 내용들을 불러온다
리스너를 등록줌으로써 스트림에 있는 값들이 실행되도록한다.
* where 함수   
stream의 리스너 작성시, where함수로 필터링 가능
ex) final streamListener2 = stream.where((val)=> val % 2 == 1).listen((val){
    print('Listener 2: $val');
  });
* yield, async*   
yield로 하나의 함수에서 여러값을 계속 반환할 수 있음   
cf) return을 쓰는 경우 함수가 종료된다   
함수로 스트림을 반환할 수 있음,  async* 작성해줘야함   
* yield*, async*   
yield* 뒤에 있는 값들을 모두 반환한 뒤에 다음 코드가 실행됨   
Stream을 await를 쓰는 것과 같은 효과를 줌   
async*를 작성해줘야함
