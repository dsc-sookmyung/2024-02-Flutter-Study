
## 앱을 만드는 흐름

AppBar를 삭제하고 싶어
-> 

```dart
import 'package:flutter/material.dart';

class Player {
  String? name;
  
  Player({required this.name});
}

void main() {
  var nico = Player(name: "potato");
  
  runApp(App());
}

class App extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.
              end,
              children: [
                Column(
                children: [
                  Text(
                    'Hey, Selena',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('Hello world!'),
                ],
               )
             ],
            )
          ],
         
        ),      
      ),
    );
  }
}

```
