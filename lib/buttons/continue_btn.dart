import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class ContinueButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;

      double containerWidth =
          isMobile ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.5;

      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: whiteColor,
          elevation: 8,
          fixedSize: Size(containerWidth * 0.8, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    });
  }
}
