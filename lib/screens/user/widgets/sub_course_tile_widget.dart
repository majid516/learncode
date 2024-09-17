import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/constants/tile_colours.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/admin_screens/admin_playlist_page.dart';
import 'package:learncode/screens/user/user_screens/user_playlist_page.dart';

// ignore: must_be_immutable
class SubTutorialTileWidget extends StatelessWidget {
  final int index;
  final int courseint;
  String subcourseImage;
  bool isAdmin;
  final Course course;
  final List<SubCourse> subCourse;
  final int courseId;
  SubTutorialTileWidget({
    required this.subcourseImage,
    required this.index,
    required this.courseint,
    required this.subCourse,
    super.key,
    required this.isAdmin,
    required this.course,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final currentSubCourse = subCourse[index];
    return InkWell(
      onTap: () {
        if (isAdmin) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AdminPlaylistPage(
              subVideo: 'asset/video/3195394-uhd_3840_2160_25fps.mp4',
              isAdmin: isAdmin,
              subCourseId: currentSubCourse.id!,
              index: index,
              courseIndex: courseint,
              subIndex: index,
              subCourseName: currentSubCourse.subCourseTitle,
              subImage: subcourseImage,
              courseId: courseId,
            ),
          ));
        } else if (enrolledLabel()) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => UserPlayListPage(
              subVideo: 'asset/video/3195394-uhd_3840_2160_25fps.mp4',
              subCourseId: currentSubCourse.id!,
              index: index,
              courseIndex: courseint,
              subIndex: index,
              subCourseName: currentSubCourse.subCourseTitle,
              subImage: subcourseImage,
            ),
          ));
        } else {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: const Text(
                  'You are not enrolled in\nthis course.\nplease enroll now!!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text(
                      'OK',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.minWidth < 600;

      double containerWidth =
          isMobile ? constraints.maxWidth * 0.7 : constraints.maxWidth * 0.8;
      double containerHieght =
          isMobile ? constraints.maxWidth * 0.7 : constraints.maxWidth * 0.3;
      double imgWidth =
          isMobile ? constraints.maxWidth * 0.6 : constraints.maxWidth * 0.2;
      double imgHeight =
          isMobile ? constraints.maxWidth * 0.4 : constraints.maxWidth * 0.2;

          return
        Stack(
          children: [
            Container(
              width: containerWidth,
              height: containerHieght,
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
                    width: imgWidth,
                    height: imgHeight,
                    decoration: BoxDecoration(
                   image: kIsWeb
                          ? DecorationImage(
                             image: MemoryImage(base64Decode(currentSubCourse.subCourseThumbnailPath)),
                              fit: BoxFit.fill,
                            )
                          : DecorationImage(
                              image: FileImage(File(currentSubCourse.subCourseThumbnailPath)),
                              fit: BoxFit.fill,
                            ),
                  
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 10,
                        ),
                      ],
                    ))),
            Positioned(
              top:kIsWeb?250: 150,
              left: 25,
              child: Text(currentSubCourse.subCourseTitle,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: whiteColor)),
            ),
          ],
        );
        }
      ),
    );
  }

  bool enrolledLabel() {
    for (var element in enrolledCourseNotifier.value) {
      // print(element.id);
      if (element.id == course.id) {
        return true;
      }
    }
    return false;
  }
}
