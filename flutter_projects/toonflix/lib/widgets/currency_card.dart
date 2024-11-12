import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  // 다르게 주고 싶은 값들을 필드로 빼준다
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final double order;
  // 색상 상수화 - private
  final _blackColor = const Color(0xFF1F2123);

  // 생성자
  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // code challenge
    double offset = 0;

    switch (order) {
      case 1:
        offset = 0;
        break;
      case 2:
        offset = -20;
        break;
      case 3:
        offset = -40;
        break;
      default:
        offset = 0;
    }
    return Transform.translate(
      // Container의 위치 조정
      offset: Offset(0, offset),
      child: Container(
        // Container 바깥의 아이템들은 모두 잘라내도록 한다
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          // 색상이 반전되는 부분 - 조건
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Text(
                      amount,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      code,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ]),
                ],
              ),
              // Icon의 크기 조정
              Transform.scale(
                scale: 2.2,
                // Icon의 위치 조정
                child: Transform.translate(
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
