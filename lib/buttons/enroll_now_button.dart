import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';

class EnrollNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const EnrollNowButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
        width: ScreenSize.widthMed*0.4,
        height: 30,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(92, 0, 240, 1),
              Color.fromARGB(255, 132, 77, 219)
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child:const Center(
          child: Text(
            'Enroll Now',
            style:  TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),);
  }
}