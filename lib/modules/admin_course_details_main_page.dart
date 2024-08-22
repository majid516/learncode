import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_course_details.dart';
import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';
import 'package:learncode/screens/admin/add_course/add_sub_couse_thumbnail.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_course_details.dart';
import 'package:learncode/screens/user/widgets/sub_course_tile_widget.dart';
import 'package:video_player/video_player.dart';

class AdminTutorialMainPageDetails extends StatefulWidget {

  final String introVideo;
  final String tutorialTitle;
  final String description;
  final int id;
  final int index;
  final String courseImage;

  
  const AdminTutorialMainPageDetails({
    super.key,
    required this.introVideo,
    required this.tutorialTitle,
    required this.description,
    required this.id,
    
    required this.index, required this.courseImage, 
  });

  @override
  State<AdminTutorialMainPageDetails> createState() =>
      _AdminTutorialMainPageDetailsState();
}

class _AdminTutorialMainPageDetailsState
    extends State<AdminTutorialMainPageDetails> {
  late FlickManager flickManager;
  List<SubCourse> filteredSubCourses = [];
  

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(File(widget.introVideo))
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          print('video is not working');
          return null;
        }),
    );

    fetchSubCourses(widget.tutorialTitle);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  Future<void> fetchSubCourses(String courseName) async {
    List<SubCourse> allSubCourses = await getAllSubCourses();

    print('All SubCourses:');
    allSubCourses.forEach((subCourse) {
      print(
          'Course Name: ${subCourse.courseName}, SubCourse Title: ${subCourse.subCourseTitle}');
    });

    setState(() {
      filteredSubCourses = allSubCourses
          .where((subCourse) =>
              subCourse.courseName.toLowerCase() == courseName.toLowerCase())
          .toList();
    });

    print('Filtered SubCourses length: ${filteredSubCourses.length}');
    filteredSubCourses.forEach((subCourse) => print(subCourse.subCourseTitle));
  }

  Future<List<SubCourse>> getAllSubCourses() async {
    final box = await Hive.openBox<SubCourse>('AddNewSubCourse');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    CustomBackButton(
                        buttonColor: buttonGrey,
                        iconColor: themeTextColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const SizedBox(
                      width: 120,
                    ),
                    const Text(
                      'Details',
                      style: tutorialPageTitletextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: ScreenSize.widthMed * 0.9,
                  height: ScreenSize.heightMed * 0.26,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tutorialTitle,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 230,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredSubCourses.length,
                      itemBuilder: (ctx, index) {
                        if (index < filteredSubCourses.length) {
                          return SubTutorialTileWidget(
                            subCourse: filteredSubCourses,
                            index: index,
                            courseint: widget.index,
                            subcourseImage: filteredSubCourses[index].subCourseThumbnailPath,
                          );
                        } else {
                          // This block should never be reached since `itemCount` is set to `filteredSubCourses.length`.
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              // deleteCourse(courseNotifier.value[widget.id].id!);
                              // Navigator.of(context).pop();
                            },
                            child: Text('delete')),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => UpdateCourseDetails(CourseIndex: widget.index,courseImage: widget.courseImage,courseVideo: widget.introVideo,courseTitle: widget.tutorialTitle,courseDiscription: widget.description,)
                              );
                            },
                            child: Text('update')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => AddSubCourseThumbnail(
                                        indexCourse: widget.index,
                                        course: courseNotifier.value[widget.id],
                                        courseNamee: widget.tutorialTitle,
                                      )));
                            },
                            child: Text('add sub course')),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
