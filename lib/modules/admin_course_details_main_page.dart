import 'dart:developer';
import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/add_sub_course.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/buttons/delete_button.dart';
import 'package:learncode/buttons/enroll_button.dart';
import 'package:learncode/buttons/update_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_sub_couse_thumbnail.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_course_details.dart';
import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
import 'package:learncode/screens/user/widgets/enrolling_alert.dart';
import 'package:learncode/screens/user/widgets/sub_course_tile_widget.dart';
import 'package:video_player/video_player.dart';

class AdminTutorialMainPageDetails extends StatefulWidget {
  final String introVideo;
  final String tutorialTitle;
  final String description;
  final int id;
  final int index;
  final String courseImage;
  final bool isAdmin;
  final Course course;
  const AdminTutorialMainPageDetails({
    super.key,
    required this.introVideo,
    required this.tutorialTitle,
    required this.description,
    required this.id,
    required this.index,
    required this.courseImage,
    this.isAdmin = false,
    required this.course,
  });
    static int playlistCount = 0;
  @override
  State<AdminTutorialMainPageDetails> createState() =>
      _AdminTutorialMainPageDetailsState();
}

class _AdminTutorialMainPageDetailsState
    extends State<AdminTutorialMainPageDetails> {
  
  late FlickManager flickManager;
  ValueNotifier<List<SubCourse>> filteredSubCoursesNotifier = ValueNotifier([]);

  @override
  void initState() {
    getAllEnrolledCourse();

    super.initState();
    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.file(File(widget.introVideo))
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          return null;
        }),
    );
   filterPlaylist(widget.id);
   
    fetchSubCourses(widget.tutorialTitle);
  }

  @override
  void dispose() {
    flickManager.dispose();
    filteredSubCoursesNotifier.dispose();
    super.dispose();
  }

  Future<void> fetchSubCourses(String courseName) async {
    List<SubCourse> allSubCourses = await getAllSubCourses();

    filteredSubCoursesNotifier.value = allSubCourses
        .where((subCourse) => subCourse.courseId == widget.id)
        .toList();

    // print(
    // 'Filtered SubCourses length: ${filteredSubCoursesNotifier.value.length}');
    filteredSubCoursesNotifier.value
        .forEach((subCourse) => print(subCourse.subCourseTitle));
  }

  Future<List<SubCourse>> getAllSubCourses() async {
    final box = await Hive.openBox<SubCourse>('AddNewSubCourse');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    getAllSubCourses();
    fechingSubcourse();
   final enrolledProvider = EnrolledCourseProvider.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        buttonColor: buttonGrey,
                        iconColor: themeTextColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const Text(
                      'Details',
                      style: tutorialPageTitletextStyle,
                    ),
                    widget.isAdmin
                        ? const SizedBox()
                        : enrolledProvider.isExist(widget.course)
                           
                            ? Container(
                                width: ScreenSize.widthMed * 0.2,
                                height: 30,
                                decoration: BoxDecoration(
                                    gradient: themePurple,
                                    borderRadius: BorderRadius.circular(10)),
                                child:const Center(
                                    child: Text(
                                  'enrolled',
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w600),
                                )),
                              )
                            : EnrollButton(onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => EnrollingAlert(
                                          progressPoint: 2,
                                          totalPoint: AdminTutorialMainPageDetails.playlistCount,
                                          courseId: widget.id,
                                          course: widget.course,
                                        ));
                              }),
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
                padding: const EdgeInsets.all(16.0),
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
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 30),
                    ValueListenableBuilder<List<SubCourse>>(
                      valueListenable: filteredSubCoursesNotifier,
                      builder: (context, filteredSubCourses, child) {
                       
                        if (filteredSubCourses.isEmpty) {
                          return SizedBox(
                              width: ScreenSize.widthMed,
                              height: ScreenSize.widthMed * 0.5,
                              child: const Center(
                                  child: Text('No SubCourse Available')));
                        }
                        return GridView.builder(
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
                            return InkWell(
                              child: SubTutorialTileWidget(
                                courseId: widget.id,
                                course: widget.course,
                                isAdmin: widget.isAdmin,
                                subCourse: filteredSubCourses,
                                index: index,
                                courseint: widget.index,
                                subcourseImage: filteredSubCourses[index]
                                    .subCourseThumbnailPath,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.isAdmin == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AddSubCourseButton(
                                title: '+ add sub course',
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => AddSubCourseThumbnail(
                                        indexCourse: widget.index,
                                        course: courseNotifier.value[widget.id],
                                        courseNamee: widget.tutorialTitle,
                                      ),
                                    ),
                                  );
                                  fetchSubCourses(widget.tutorialTitle);
                                },
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 15),
                    widget.isAdmin == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DeleteButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          content:const Text(
                                            'are you sure to remove this course',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:const Text(
                                                  'cancel',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  deleteCourse(widget.id);
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child:const Text(
                                                  'delete',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ],
                                        );
                                      });
                                },
                              ),
                              UpdateButton(onpressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => UpdateCourseDetails(
                                          courseTitle: widget.tutorialTitle,
                                          courseIndex: widget.index,
                                          courseDiscription: widget.description,
                                          courseImage: widget.courseImage,
                                          courseVideo: widget.introVideo,
                                        ));
                              }),
                            ],
                          )
                        :  ElevatedButton(
                         child: Text('data'),
                         onPressed: () {
                          filterPlaylist(widget.id);
                         },
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
void filterPlaylist(int courseId) {
 int count = 0;
  List<SubCourse> subCourses = subCourseNotifier.value.where((sub) => sub.courseId == courseId).toList();
  log('SubCourses found: ${subCourses.length} for Course ID: $courseId');
  for (var subCourse in subCourses) {
    log('SubCourse ID: ${subCourse.courseId}, SubCourse Title: ${subCourse.subCourseTitle}');
    if (subCourse.tutorialPlayList.isNotEmpty) {
      log('Playlist found with length: ${subCourse.tutorialPlayList.length}');
     count += subCourse.tutorialPlayList.length;
    } else {
      log('No playlists found for SubCourse: ${subCourse.subCourseTitle}');
    }
  }
  log('Total Playlists under course $courseId: ${count}');
  AdminTutorialMainPageDetails.playlistCount = count;
  print('count === ${AdminTutorialMainPageDetails.playlistCount}');
}


}


