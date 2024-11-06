import 'dart:async';

void main(){
  playAllStream().listen((val){
    print(val);
  });
}

// Stream을 await처럼 쓸 수 있게됨
Stream<int> playAllStream() async* {
  yield* calculate(1);
  yield* calculate(1000);
}

Stream<int> calculate(int number) async* {
  for (int i =0; i< 5; i++){
    yield i* number;
    
    await Future.delayed(Duration(seconds: 1));
  }
}
