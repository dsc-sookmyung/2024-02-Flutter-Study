void main() {
  // 1. where 함수 - 조건을 줘서 맞는 값을 리턴함
  
  List<Map<String, String>> people = [
    {
      'name': '로제',
      'group': '블랙핑크',
    },
    {
      'name': '지수',
      'group': '블랙핑크',
    },
    {
      'name': 'RM',
      'group': 'BTS',
    },
    {
      'name': '뷔',
      'group': 'BTS',
    }
    
  ];
    
  print(people);
  final blackPink = people.where((x)=>x['group']=='블랙핑크').toList();
  final bts = people.where((x)=> x['group']=='BTS').toList();
  
  print(blackPink);
  print(bts);

  // 2. reduce 함수 - reduce를 실행하고 있는 리스트의 타입과 동일한 타입으로 반환
  
  // int 타입
  List<int> numbers = [1, 3, 5, 7, 9];
  
  // 1) 괄호로 묶어서 반환
  final result = numbers.reduce((prev, next) {
    print('-------------');
    print('previous: $prev');
    print('next: $next');
    print('total: ${prev + next}');

    return prev + next;
  });
  // 2) arrow함수로 반환
  final result2 = numbers.reduce((prev, next) => prev + next);

  print(result);

  // String 타입
  List<String> words = ['안녕하세요 ', '저는 ', '코드팩토리입니다.'];
  
  final sentence = words.reduce((prev, next) => prev + next);
  print(sentence);

  //words.reduce((prev, next) => prev.length + next.length);
  // reduce함수는 실행하고 있는 리스트의 타입과 동일한 타입으로 반환해야하기 때문에 위의 코드에 에러가 남

  // 3. fold 함수 - reduce와 유사, reduce의 단점 보완
  // 리스트의 타입과 반환하는 타입이 동일하지 않아도 됨, 제네릭 사용

  // int 타입
  //List<int> numbers = [1, 3, 5, 7, 9];
  // 1) 괄호로 묶어서 반환
  final sum = numbers.fold<int>(0, (prev, next){
    print('--------------');
    print('prev : $prev');
    print('next : $next');
    print('total : ${prev+ next}');
    
    return prev+ next;
  });
  
  // 2) arrow함수로 반환
  final sum2 = numbers.fold<int>(0, (prev, next) => prev + next);
  print(sum);
  
  // String 타입
  List<String> words = [
    '안녕하세요 ', '저는 ', '코드팩토리입니다.'
  ];
 
  //리스트의 자료형과 같 자료형을 리턴
  final sentence = words.fold<String>('', (prev, next) => prev + next);
  print(sentence);
  
  //리스트의 자료형과 다른 자료형을 리턴
  final count = words.fold<int>(0, (prev, next) => prev + next.length);
    print(count);

// 4. cascading 함수
  
void main() {
  List<int> even = [
    2, 4, 6, 8,
  ];
  List<int> odd = [
    1, 3, 5, 7, 
  ];
  
  //cascading operator
  // ..
  
  print([...even, ...odd]);
  print(even);
  print([...even]);
  print(even == [...even]);
}
}
