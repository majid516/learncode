import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final Icon icon;
  const FavouriteButton(
      {super.key,
      required this.buttonColor,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: IconButton(onPressed: onPressed, icon: icon),
    );
  }
}
