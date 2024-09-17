import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/course.dart';

class TutorialTileWidget extends StatelessWidget {
  final Course course;
  final VoidCallback onPressed;
 
  const TutorialTileWidget({
    super.key,
    required this.course,
    required this.onPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
                bool isMobile = constraints.minWidth < 600;

          double imgWidth =
          isMobile ? constraints.maxWidth * 0.6 : constraints.maxWidth * 0.5;
             double imgHieght =
          isMobile ? constraints.maxWidth * 0.5 : constraints.maxWidth * 0.4;
     double containerWidth =
          isMobile ? constraints.maxWidth * 0.75 : constraints.maxWidth * 0.6;
             double containerHieght =
          isMobile ? constraints.maxWidth * 0.6 : constraints.maxWidth * 0.42;
      
     return InkWell(
        onTap: onPressed, 
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: containerWidth,
                height: containerHieght,
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
                child: Padding(
                  padding:  EdgeInsets.only(top: kIsWeb?ScreenSize.heightMed*0.28: 115, left:kIsWeb?50: 20 ,),
                  child: Text(
                    course.courseTitle,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Positioned(
              top:kIsWeb?ScreenSize.heightMed*0.1: 0,
              left:kIsWeb?ScreenSize.widthMed*0.077: 28,
              child: FractionalTranslation(
                translation: const Offset(-0.06, -0.2),
                child: Container(
                  width: imgWidth,
                  height: imgHieght,
                  decoration: BoxDecoration(
                   image: kIsWeb
                          ? DecorationImage(
                              image: MemoryImage(base64Decode(course.courseThumbnailPath)),
                              fit: BoxFit.fill,
                            )
                          : DecorationImage(
                              image: FileImage(File(course.courseThumbnailPath)),
                              fit: BoxFit.fill,
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
    );
  }
}
