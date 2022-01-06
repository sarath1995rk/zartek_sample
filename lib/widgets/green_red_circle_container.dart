import 'package:flutter/material.dart';

class GreenCircleContainer extends StatelessWidget {
  final Color color;

  GreenCircleContainer(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
