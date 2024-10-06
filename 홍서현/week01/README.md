# 1주차: 함수형 프로그래밍 알아보기
<strong>Dart #3 Functional Programming 함수형 프로그래밍 강의 내용 정리</strong><br>

<em>함수형 프로그래밍의 기본은 형변환이다.</em><br><br>
<strong>List <--> Map <--> Set</strong><br>
```
void main() {
	List<String> blackPink = ['로제', '지수', '리사', '제니', '제니'];

	print(blackPink);
	print(blackPink.asMap());
	print(blackPink.toSet());

	Map blackPinkMap = blackPink.asMap();
	
	print(blackPinkMap.keys.toList());
	print(blackPinkMap.values.toList());

	Set blackPinkSet.toList());

	print(blackPinkSet.toList());

}
```
<code>.asMap()</code>을 이용해 맵으로 변환하고 <code>.toSet()</code>을 이용해 중복 제거하여 셋으로 변환할 수 있다.<br>
<code>.toList()</code>이용해 다시 리스트로 변환 가능하다.<br><br>
<strong>List<->Map</strong><br>
```
void main() {
	List<String> blackPink = ['로제', '지수', '리사', '제니'];

	final newBlackPink = blackPink.map((x){
		 return '블랙핑크 $x';
	});

	print(blackPink);
	print(newBlackPink.toList());

	final newBlackPink2 = blackPink.map((x) => '블랙핑크 $x');

	print(newBlackPink2.toList());

	print(blackPink == blackPink); //map 함수 사용 -> 새로운 리스트
	print(newBlackPink == blackPink);
	print(newBlackPink == newBlackPink2);

	String number = '13579';

	final parsed = number.split('').map((x) => '$x.jpg').toList();
	print(parsed);
}
```
<code>final newBlackPink2 = blackPink.map((x) => '블랙핑크 $x');</code>에서 <code>map()</code>은 리스트의 각 요소를 변환한다. 이때 앞에 '블랙핑크' 단어를 붙여 변환하도록 람다함수를 사용한다. 
<code>newBlackPink2.toList()</code>는 맵을 다시 리스트로 변환한다. 이때 생성되는 리스트는 기존 리스트와 다른 <b>새로운 리스트</b>로 <b>데이터 불변성</b>을 유지할 수 있다. <br><br>
<Strong>Map.key, Map.value</strong><br>
```
void main() {
	Map<String, String> harryPotter = {
    'HarryPotter' : '해리포터',
    'Ron Weasley' : '론 위즐리',
    'Hermione Granger' : '헤르미온느 그레인저'
  };
  
  final result = harryPotter.map(
  (key,value)=>MapEntry(
    'Harry Potter Character $key',
    '해리포터 캐릭터 $value',
  ),
  );
  
  print(harryPotter);
  print(result);
  
  final keys = harryPotter.keys.map((x)=>'HPC $x').toList();
  final values = harryPotter.values.map((x)=>'해리포터 $x').toList();
  
  print(keys);
  print(values);
  
}
```
<code>final result = harryPotter.map((key, value) => MapEntry('Harry Potter Character $key','해리포터 캐릭터 $value',),);</code>에서 기존 맵에서 키와 값을 새로운 형태로 변형하여 새로운 맵을 생성한다. <code>MapEntry</code>와 람다 함수를 사용해 새로운 형태로 변환한다. <br><br>
<strong>where</strong><br>
```
void main() {
  List<Map<String, String>> people = [
    {
      'name':'로제',
      'group':'블랙핑크',
    },
    {
      'name':'리사',
      'group':'블랙핑크',
    },
    {
      'name':'RM',
      'group':'BTS',
    },
    {
      'name':'뷔',
      'group':'BTS',
    }
  ];

  print(people);
  final blackPink = people.where((x)=>x['group']=='블랙핑크').toList();
  final bts = people.where((x)=>x['group']=='BTS').toList();
  print(blackPink);
  print(bts);
}
```
<code>final blackPink = people.where((x) => x['group'] == '블랙핑크').toList();</code>를 사용하면 맵에서 group값이 블랙핑크인 경우만 반환한다. <code>where()</code>를 이용하여 요소들을 필터링하여 조건을 만족하는 요소들 만을 취할 수 있다.<br><br>
<strong>reduce</strong><br>
```
void main() {
  List<int> numbers = [
    1,
    3,
    5,
    7,
    9
  ];
  
  final result = numbers.reduce((prev, next) => prev+next);
  
  print(result);
  
  List<String> words = [
    '안녕하세요',
    '저는 ',
    '홍서현입니다. ',
  ];
  
  final sentence = words.reduce((prev, next) => prev + next);
  print(sentence);
  
  //words.reduce((prev, next) => prev.length+next.length); error!  String으로만 리턴 가능 다른 타입 불가
  
  
}
```
<code>reduce()</code>는 요소들을 누적 처리하여 단일 결과로 만든다.<code>List<int> numbers = [1, 3, 5, 7, 9];</code>인 리스트가 있다고 할 때 <code>final result = numbers.reduce((prev, next) => prev + next);</code>를 실행하면 해당 리스트의 총 합이 <code>result</code>에 저장된다. 단 <code>reduce()</code>는 앞서 지정한 타입으로만 사용이 가능하다. 위의 경우는 타입을 <code>int</code>으로 지정했기 때문에 정수형 계산만 가능하다. <br><br>
<Strong>fold</strong><br>
```
void main() {
  List<int> numbers = [1,3,5,7,9];
  
  final sum = numbers.fold<int>(0, (prev, next) => prev+next);
  print(sum);
  
  List<String> words = [
    '안녕하세요',
    '저는 ',
    '홍서현입니다. ',
  ];

  final sentence = words.fold<String>('',(prev, next)=>prev+next);
  print(sentence);
  final count = words.fold<int>(0, (prev, next)=>prev+next.length);
  print(count);
  
}
```
<code>fold()</code>는 <code>reduce()</code>와 같은 기능을 하지만 초기값을 지정할 수 있다는 장점이 있다. <code>List<String> words = ['안녕하세요 ', '저는 ', '홍서현입니다.'];</code>라는 리스트가 있다고 할 때 <code>final count = words.fold<int>(0, (prev, next) => prev + next.length);</code>에서 초기값을 0으로 지정했고 정수 계산을 위해 타입을 <code>int</code>으로 지정했다. 따라서 해당 리스트는 <code>String</code>형이지만 정수 계산이 가능하다.<br><br>
<strong>...list</strong><br>
```
void main() {
  List<int> even = [
    2,4,6,8
  ];
  List<int> odd = [
    1,3,5,7
  ];
  
  print([even, odd]);
  print([...even, ...odd]); 
  print(even==[...even]); //새로운 리스트 생성
}
```
스프레드 연산자 <code>...</code>를 이용해 리스트 요소를 펼쳐서 하나의 리스트로 병합할 수 있다. 마찬가지로 데이터 불변성 유지를 위해 요소 값이 같더라도 서로 다른 새로운 리스트로 생성된다. <br><br>
<strong>객체 변환</strong><br>
```
void main() {
  
  final List<Map<String, String>> people = [
    {
      'name':'로제',
      'group':'블랙핑크',
    },
    {
      'name':'리사',
      'group':'블랙핑크',
    },
    {
      'name':'RM',
      'group':'BTS',
    },
    {
      'name':'뷔',
      'group':'BTS',
    }
  ];
  
  print(people);
  
  final parsedPeople = people
    .map(
      (x) => Person(
        name: x['name']!,
        group: x['group']!
      )
    ).toList();
  //print(parsedPeople);
  final bts = parsedPeople.where(
  (x)=>x.group == 'BTS');
  
  print(bts);
  
  final result = people.map(
  (x)=>Person(
    name:x['name']!,
    group:x['group']!
  )
  ).where((x)=>x.group == 'BTS')
    .fold<int>(0, 
               (prev,next)=>prev+next.name.length);
}

  class Person {
    final String name;
    final String group;
    
    Person({
      required this.name,
      required this.group,
    });
    
    @override
    String toString(){
      return 'Person(name: $name, group: $group)';
    }
  }
```
<code>final parsedPeople = people.map((x) => Person(name: x['name']!, group: x['group']!)).toList();</code>는 people 리스트에 있는 각 맵을 <code>Person</code> 클라스 객체로 변환한다. 각 항목을 객체로 변환한 뒤 다시 리스트로 변환한다. <code>!</code>를 붙인 이유는 해당 이름의 필드가 반드시 존재한다는 의미이다. 람다 함수를 사용하기 때문에 위에서 언급한 <code>where</code>,<code>reduce</code>등을 코드 한줄에 같이 사용 가능하다. 
