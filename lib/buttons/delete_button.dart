import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: 
        onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(ScreenSize.widthMed * 0.35, 50),
          side: const BorderSide(
            color: Color.fromARGB(255, 196, 33, 21),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: homeColor),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: Color.fromARGB(255, 187, 30, 19),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'delete',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 196, 30, 18)),
          ),
        ],
      ),
    );
  }
}
