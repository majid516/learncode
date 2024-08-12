import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomLikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color iconColor;
  const CustomLikeButton(
      {super.key,
      required this.buttonColor,
      required this.onPressed,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(139, 0, 0, 0),
              offset: Offset(-01, 1),
              blurRadius: 6,
            )
          ]),
      child: Icon(
        FontAwesomeIcons.heart,
        color: iconColor,
      ),
    );
  }
}
