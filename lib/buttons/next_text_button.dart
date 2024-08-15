import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';

class NextTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NextTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        label:const Wrap(children:  [ Text('next',style: TextStyle(color: themeTextColor,fontWeight: FontWeight.w600),),Icon(Icons.arrow_forward,color: themeTextColor,size: 22,),]));
  }
}
