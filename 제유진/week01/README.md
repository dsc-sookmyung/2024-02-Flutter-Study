# 3. 함수형 프로그래밍(Functional Programming)
## 3.1 리스트, 맵, 세트의 형변환
List, Map, Set 각각 형 변환하기 위해 
toList(), asMap(), toSet() 사용
-> map으로 형변환할때는 as!

Set, Map : {}   
list : []   
key, value : ()   
-> 이를 리스트로 만들어주기 위해  toList()를 사용   
ex) print(blackPinkMap.keys.toList());
## 3.2 맵핑함수 - 리스트, 맵, 세트
List, Map, Set에 각각 map함수 사용가능   
함수형 프로그래밍을 통해   
ex) blackPink.map((x) => '블랙핑크 $x');   
이런식으로 작성 가능
1) 괄호 안에 return을 넣어서 반환   
2) => (arrow)함수로 반환
- 특이점:
map은 MapEntry를 통해 맵의 키와 값을 동시에 반환 가능   
ex) hp.map((key, value) => MapEntry(
    'Harry Potter Character $key',
    '해리포터 캐릭터 $value',
      )
  );

## 3.3 where, reduce, fold, cascading
* where 함수   
  조건을 줘서 맞는 값을 리턴함   
  ex) people.where((x)=>x['group']=='블랙핑크').toList()   
* reduce 함수   
  실행하고 있는 리스트의 타입과 동일한 타입으로 반환   
  반환되는 값이 다음의 prev로 들어감   
  ex) numbers.reduce((prev, next) => prev + next   
* fold 함수   
  reduce와 유사, reduce의 단점 보완   
  리스트의 타입과 반환하는 타입이 동일하지 않아도 됨, 제네릭 사용   
  numbers.fold<int>(0, (prev, next) => prev + next)   
* cascading 함수   
  출력을 연속적으로 한다.   
  ex) print([...even, ...odd]); --> 두개의 리스트가 하나의 리스트처럼 이어진다.
