# 2024-02-Flutter-Study

[24-25 GDG on Campus Sookmyung 5기] 1분기 스터디(Flutter)를 위한 저장소

## 👩‍💻 스터디원

- Core: 전시원
- Member: 안예빈, 제유진, 최우진, 홍서현, 홍정인

## 🤝 스터디 소개

- [GDG on Campus Sookmyung Flutter Study Notion](https://orange-whale-5b0.notion.site/1-Flutter-9cf96f00353040c5bdac95dfbb67c2d1?pvs=4)

### 커리큘럼

| 주차  | 주제                      |          진척도          |
| ----- | ------------------------- | :----------------------: |
| 1주차 | 함수형 프로그래밍 알아보기        | <ul><li>- [ ] </li></ul> |
| 2주차 | 비동기 프로그래밍 알아보기          | <ul><li>- [ ] </li></ul> |
| 3주차 | Flutter 간단하게 살펴보기               | <ul><li>- [ ] </li></ul> |
| 4주차 | UI 구성해보기              | <ul><li>- [ ] </li></ul> |
| 5주차 | Widget State 이해하기   | <ul><li>- [ ] </li></ul> |
| 6주차 | 뽀모도로 앱 만들어보기              | <ul><li>- [ ] </li></ul> |
| 7주차 | Data Fetch 이해하기              | <ul><li>- [ ] </li></ul> |
| 8주차 | FutureBuilder와 ListView 이해하기              | <ul><li>- [ ] </li></ul> |
| 9주차 | api 활용해보기              | <ul><li>- [ ] </li></ul> |
| 10주차 | url Launcher 사용해보기              | <ul><li>- [ ] </li></ul> |

## 💼 과제

- 과제 마감 : **매주 수요일 자정**까지
- 제출 내용: 강의 내용 요약(README) 및 실습 코드
- 과제 제출 방법
  - 본인 GitHub으로 스터디 레포를 fork한다.
  - fork 한 레포에서 각자의 이름으로 폴더를 생성한다 (ex.) `전시원`
  - 자신의 이름 아래 주차별 폴더를 생성한다. (ex.)`week01`
  - Fork한 레포에 과제를 Commit
    - 커밋 메시지: `n주차: 학습 주제` (ex.) `1주차: OOP`
  - 수요일 자정 전까지 main 브랜치에 으로 PR 요청 - PR 제목: `n주차_이름`

## 👀 GDSC 팀블로그 작성

- 각 주차 주제별 기술 블로그 작성
- 작성 순서 : 


# 강의 요약
## Map 타입

<aside>
<img src="/icons/hashtag_gray.svg" alt="/icons/hashtag_gray.svg" width="40px" />

맵(map)타입은 키(Key)와 값(value)의 짝을 저장

 순서대로 값을 저장하는 데 중점을 두는 리스트와 달리 키를 이용해서 원하는 값을 빠르게 찾는데 중점을 둔다. 

→ Map<키의 타입, 값의 타입> 맵이름 형식으로 생성

</aside>

### 리스트 선언 → map으로 변경

```python
void main(){
  
  List<String> blackpink = ['제니', '리사', '로제', '지수']; //리스트 선언
  
  Map blackpinkMap = blackpink.asMap();
  
  print(blackpinkMap);
  print(blackpinkMap.keys);
  print(blackpinkMap.values);
}
```

**>> {0: 제니, 1: 리사, 2: 로제, 3: 지수}**

**>> (0, 1, 2, 3)
>> (제니, 리사, 로제, 지수)**

→ 주의) 리스트 변수를 선언한 뒤, 그 변수값 자체를 map으로 변환할 수는 없음. (새로운 변수명을 사용하여 map으로 선언해야 함)

- keys : map의 인덱스와 같은 개념
- values: key값에 해당하는 속성값

### 리스트 → set으로 변경

```dart
void main(){
  
  List<String> blackpink = ['제니', '리사', '로제', '지수']; //리스트 선언
  
  Set blackpinkSet = Set.from(blackpink);
  print(blackpinkSet);
}
```

**>> {제니, 리사, 로제, 지수}**

### 리스트의 map method

- return 값으로 출력

```dart
void main(){
  
  List<String> blackpink = ['제니', '리사', '로제', '지수']; //리스트 선언
  
  final newblackpink = blackpink.map((x)
  {
    return '블랙핑크 $x';});
  print(blackpink);
  print(newblackpink.toList()); // 이터러블 형태를 리스트로 바꾸는 메서드
}
```

- right arrow 사용

```dart
void main(){
  
  List<String> blackpink = ['제니', '리사', '로제', '지수']; //리스트 선언
  
  print(blackpink);
  print(newblackpink.toList());
}
```

**>> [제니, 리사, 로제, 지수]**

**>> [블랙핑크 제니, 블랙핑크 리사, 블랙핑크 로제, 블랙핑크 지수]**

### 리스트 안에 map 사용

```dart
void main() {
  List<Map<String, String>> people  = [
    {
      'name':'로제',
      'group': '블랙핑크'
    },
        {
      'name':'제니',
      'group': '블랙핑크'
    },
        {
      'name':'리사',
      'group': '블랙핑크'
    },
        {
      'name':'뷔',
      'group': 'BTS'
    }
  ];
  
  print(people);
  final blackpink = people.where((x) => x['group'] == '블랙핑크');
  print(blackpink); //iterable로 출력됨
}

```

>> **[{name: 로제, group: 블랙핑크}, {name: 제니, group: 블랙핑크}, {name: 리사, group: 블랙핑크}, {name: 뷔, group: BTS}]({name: 로제, group: 블랙핑크}, {name: 제니, group: 블랙핑크}, {name: 리사, group: 블랙핑크})**

---

## reduce 함수

<aside>
<img src="/icons/hashtag_gray.svg" alt="/icons/hashtag_gray.svg" width="40px" />

</aside>

### integer type을 더한 경우

```dart
void main() {
  List<int> numbers = [
    1,
    3,
    5,
    7,
    9
  ];
  
  final result = numbers.reduce((prev, next){
    print('-------');
    print('previous : $prev');
    print('next : $next');
    print('total : ${prev + next}');
    
    return prev + next;
  });
  
  print(result);
}
//>> 25 (결과값)
```

→ List에 있는 값들을 순회하면서 매개변수에 입력된 함수를 실행한다. 

→ ‼️ 순회할 때마다 값이 쌓이는 특징이 있음. 

```dart
  final result = numbers.reduce((prev, next) => prev + next);
```

→ 한 줄로 줄일 수 있다. 

### string type을 더한 경우

```dart
void main() {
  List<String> words = [
    '안녕하세요',
    '저는',
    '최우진',
    '입니다.'
  ];
  
  final result = words.reduce((prev, next) => prev +' '+ next);
  print(result);
}
```

**>> 안녕하세요 저는 최우진 입니다.**
