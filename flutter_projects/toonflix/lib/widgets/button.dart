import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // 해당 컨테이너에 색상을 준다
        color: bgColor,
        // 테두리가 둥글게끔 해준다
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Text(text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            )),
      ),
    );
  }
}
