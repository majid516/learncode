import 'dart:io';
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
              child: Padding(
                padding: const EdgeInsets.only(top: 115, left: 20),
                child: Text(
                  course.courseTitle,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
                  image: DecorationImage(
                    image: FileImage(File(course.courseThumbnailPath)),
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
