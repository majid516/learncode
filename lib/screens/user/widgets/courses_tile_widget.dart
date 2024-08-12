import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class TutorialTileWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const TutorialTileWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, 
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: ScreenSize.widthMed * 0.43,
              height: ScreenSize.widthMed * 0.43,
             
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
               child:const Padding(
                padding:  EdgeInsets.only(top: 115, left: 20),
                child:  Text(
                  'Web designing',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 28,
            child: FractionalTranslation(
              translation: const Offset(-0.06, -0.2),
              child: Container(
                width: ScreenSize.widthMed * 0.36,
                height: ScreenSize.widthMed * 0.3,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'asset/image/5 Tips To Create Awesome Slideshows.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
