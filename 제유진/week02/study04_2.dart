void main() async{
  // 함수를 호출시 동기화
  final result1 = await addNumbers(1, 1); 
  final result2 = await addNumbers(2, 2); 
  
  print('result1: $result1');
  print('result2: $result2');
  print('result1 + result2 = ${result1 + result2}');
}

// 함수 내부적인 코드에서 동기화
Future<int> addNumbers(int number1, int number2) async {
  print('계산 시작 : $number1 + $number2');

  // 서버 시뮬레이션
  await Future.delayed(Duration(seconds: 2), () {
    print('계산 완료: $number1 + $number2 = ${number1 + number2}');
  });

  print('함수 완료: $number1 + $number2');
  return number1+ number2;
}
