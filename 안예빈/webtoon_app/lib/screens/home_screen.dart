import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //screen을 위한 기본 레이아웃 설정 제공
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        //앱바의 음영도
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
