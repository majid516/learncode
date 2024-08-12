import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {},
      
      style: ElevatedButton.styleFrom(
        fixedSize: Size(ScreenSize.widthMed*0.35, 50),
          side:const BorderSide(
            color:themeTextColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: homeColor),
          child:const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Icon(
            Icons.edit_document,
            color: themeTextColor,
          ),
        SizedBox(width: 5,),
          Text(
            'Update',
            style: TextStyle(
              fontSize: 15,
                fontWeight: FontWeight.w600,
                color:themeTextColor,
          ),
          ),
        ],
      ),
    );
  }
}