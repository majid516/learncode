import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';

class BackTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BackTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        label:const Wrap(children:  [Icon(Icons.arrow_back,color: themeTextColor,size: 22,), Text('back',style: TextStyle(color: themeTextColor,fontWeight: FontWeight.w600),)]));
  }
}
