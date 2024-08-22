import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/constants/tile_colours.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/user/user_screens/playlist_watched_page.dart';

class SubTutorialTileWidget extends StatelessWidget {
  final int index;
  // final String subTitle;
  // final String subThumnail;
  final int courseint ;
  String subcourseImage;
  final List<SubCourse> subCourse;
   SubTutorialTileWidget({
    required this.subcourseImage,
    required this.index,
    required this.courseint,
    required this.subCourse,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentSubCourse = subCourse[index];
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) =>  PlayListPage(index: index,courseIndex: courseint,subIndex: index,subCourseName: currentSubCourse.subCourseTitle,subImage: subcourseImage)));
      },
      child: Stack(
        children: [
          Container(
            width: ScreenSize.widthMed * 0.43,
            height: ScreenSize.widthMed * 0.55,
            decoration: BoxDecoration(
              gradient: tileColors[index],
              borderRadius: index.isEven
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))
                  : const BorderRadius.only(
                      topRight: Radius.circular(35),
                      bottomLeft: Radius.circular(35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          Positioned(
            top: 25,
            left: 15,
            child: Container(
              width: ScreenSize.widthMed * 0.36,
              height: ScreenSize.widthMed * 0.25,
              decoration: BoxDecoration(
                image:DecorationImage(image: FileImage(File(currentSubCourse.subCourseThumbnailPath)),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 10),
                    blurRadius: 10,
                 ),
                ],
             )
             )
            ),
          
           Positioned(
            top: 150,
            left: 25,
            child: Text(currentSubCourse.subCourseTitle,
                style:const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: whiteColor)),
          ),
        ],
      ),
    );
  }
}