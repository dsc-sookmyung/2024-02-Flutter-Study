import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffE7626C), // Scaffold 배경색
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xff232B55), // 제목 텍스트 색상
          ),
        ),
        cardColor: const Color(0xffF4EDDB), // 카드와 버튼에 사용되는 배경색
      ),
      home: const HomeScreen(),
    );
  }
}
