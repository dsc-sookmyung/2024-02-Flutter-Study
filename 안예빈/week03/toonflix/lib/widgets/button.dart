import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // ignore: use_full_hex_values_for_flutter_colors
          color: bgColor,
          borderRadius: BorderRadius.circular(45)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
    );
  }
}
