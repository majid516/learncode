import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color iconColor;
  const CustomBackButton(
      {super.key,
      required this.buttonColor,
      required this.onPressed,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow:const [
              BoxShadow(
                color: Color.fromARGB(139, 0, 0, 0),
                offset: Offset(-01, 1),
                blurRadius: 6,
              )
            ]),
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
