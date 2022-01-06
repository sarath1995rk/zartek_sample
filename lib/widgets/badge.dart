import 'package:flutter/material.dart';
import 'package:zartek_sample/others/routes.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;

  Badge(this.child, this.value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(kCartScreen);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red[400]),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
