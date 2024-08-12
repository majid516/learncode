import 'package:flutter/material.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddMoreTutorials extends StatelessWidget {
  final VoidCallback onPressed;

  const AddMoreTutorials({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: ScreenSize.widthMed*0.8,
        height: 50,
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
            '+ add more tutorials',
            style:  TextStyle(
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
