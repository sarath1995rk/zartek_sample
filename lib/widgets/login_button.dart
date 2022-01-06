import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String logo;
  final Color color;
  final String label;
  final VoidCallback press;

  LoginButton(this.logo, this.color, this.label, this.press);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)))),
          onPressed: press,
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15,
            backgroundImage: AssetImage(logo),
          ),
          label: Text(label)),
    );
  }
}
