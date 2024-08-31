import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddSubCourseButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AddSubCourseButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: ScreenSize.widthMed*0.7,
        height: 55,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(92, 0, 240, 1),
              Color.fromARGB(255, 132, 77, 219)
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
