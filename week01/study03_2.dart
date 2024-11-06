void main() {
  // 1. 리스트
 List<String> blackPink = ['로제', '지수', '리사', '제니'];

  // 1) 괄호로 묶어서 반환
  final newBlackPink = blackPink.map((x){
    return '블랙핑크 $x';
  });
  
  print(blackPink);
  print(newBlackPink.toList());

  // 2) arrow함수로 반환
  final newBlackPink2 = blackPink.map((x) => '블랙핑크 $x');
  
  print(newBlackPink2.toList());
  
  print(blackPink== blackPink); //true
  print(newBlackPink == blackPink); //false
  print(newBlackPink == newBlackPink2); //false

  String number = '13579';
  
  final parsed = number.split('').map( (x) => '$x.jpg').toList();

  print(parsed);

  // 2. 맵
  Map<String, String> hp = {
    'Harry Potter': '해리포터',
    'Ron': '론',
    'Hermione': '헤르미온느'
  };

  // 1) 괄호로 묶어서 반환 (MapEntry)
  final result = hp.map(
    (key, value) => MapEntry(
    'Harry Potter Character $key',
    '해리포터 캐릭터 $value',
      )
  );
  
  print(hp);
  print(result);

  // 2) arrow함수로 반환
  final keys = hp.keys.map((x) => 'HPC $x').toList();
  final values = hp.values.map((x)=>'해리포터 캐릭터 $x').toList();
  
  print(keys);
  print(values);


  // 3. 세트
  void main() {
  Set blackPinkSet = {
    '로제',
    '지수',
    '제니',
    '리사',
  };

  // arrow함수로 반환
  final newSet = blackPinkSet.map((x)=> '블랙핑크 $x').toSet();
    
  print(newSet);
  }
}
