// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';

// class AddCourseThumbnail extends StatefulWidget {
//   const AddCourseThumbnail({super.key});

//   static final courseTitleController = TextEditingController();
//   static String? thumbnail;

//   @override
//   State<AddCourseThumbnail> createState() => _AddCourseThumbnailState();
// }

// class _AddCourseThumbnailState extends State<AddCourseThumbnail> {
//   final ImagePicker picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           InkWell(
//             onTap: pickImageFromGallery,
//             child: Container(
//               width: ScreenSize.widthMed * 0.4,
//               height: ScreenSize.widthMed * 0.3,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(15),
//                 image: AddCourseThumbnail.thumbnail != null
//                     ? DecorationImage(
//                         image: FileImage(File(AddCourseThumbnail.thumbnail!)),
//                         fit: BoxFit.fill,
//                       )
//                     : null,
//               ),
//               child: Center(
//                 child: Text(
//                   'Image not selected',
//                   style: TextStyle(
//                     color: AddCourseThumbnail.thumbnail == null
//                         ? Colors.black
//                         : Colors.transparent,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: ScreenSize.heightMed * 0.03),
//           const Text(
//             'add course thumbnail',
//             style: addTutorialPagestyle,
//           ),
//           SizedBox(height: ScreenSize.heightMed * 0.05),
//           Container(
//             width: ScreenSize.widthMed * 0.75,
//             height: 60,
//             decoration: BoxDecoration(
//               color: whiteColor,
//               borderRadius: BorderRadiusDirectional.circular(12),
//               border: Border.all(width: 0.2),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color.fromARGB(95, 0, 0, 0),
//                   blurRadius: 2,
//                   offset: Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: TextFormField(
//               controller: AddCourseThumbnail.courseTitleController,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(borderSide: BorderSide.none)),
//             ),
//           ),
//           SizedBox(height: ScreenSize.heightMed * 0.03),
//           const Text(
//             'add course title',
//             style: addTutorialPagestyle,
//           ),
//           SizedBox(height: ScreenSize.heightMed * 0.12),
//         ],
//       ),
//     );
//   }

//   Future<void> pickImageFromGallery() async {
//     final XFile? selectedImage =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (selectedImage != null) {
//       setState(() {
//         AddCourseThumbnail.thumbnail = selectedImage.path;
//       });
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddCourseThumbnail extends StatefulWidget {
  const AddCourseThumbnail({super.key});

  static final courseTitleController = TextEditingController();
  static String? thumbnail;

  @override
  State<AddCourseThumbnail> createState() => _AddCourseThumbnailState();
}

class _AddCourseThumbnailState extends State<AddCourseThumbnail> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: pickImage,
            child: Container(
              width: ScreenSize.widthMed * 0.4,
              height: ScreenSize.widthMed * 0.3,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                image: AddCourseThumbnail.thumbnail != null
                    ? (kIsWeb
                        ? DecorationImage(
                            image: MemoryImage(base64Decode(AddCourseThumbnail.thumbnail!)),
                            fit: BoxFit.fill,
                          )
                        : DecorationImage(
                            image: FileImage(File(AddCourseThumbnail.thumbnail!)),
                            fit: BoxFit.fill,
                          ))
                    : null,
              ),
              child: Center(
                child: Text(
                  'Image not selected',
                  style: TextStyle(
                    color: AddCourseThumbnail.thumbnail == null
                        ? Colors.black
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenSize.heightMed * 0.03),
          const Text(
            'add course thumbnail',
            style: addTutorialPagestyle,
          ),
          SizedBox(height: ScreenSize.heightMed * 0.05),
          Container(
            width: ScreenSize.widthMed * 0.75,
            height: 60,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.circular(12),
              border: Border.all(width: 0.2),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(95, 0, 0, 0),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: TextFormField(
              controller: AddCourseThumbnail.courseTitleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: ScreenSize.heightMed * 0.03),
          const Text(
            'add course title',
            style: addTutorialPagestyle,
          ),
          SizedBox(height: ScreenSize.heightMed * 0.12),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      if (kIsWeb) {
        var imageBytes = await selectedImage.readAsBytes();
        setState(() {
          AddCourseThumbnail.thumbnail = base64Encode(imageBytes);
        });
      } else {
        setState(() {
          AddCourseThumbnail.thumbnail = selectedImage.path;
        });
      }
    }
  }
}




// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';  // Keep this import for mobile file handling
// // import 'dart:ui_web';
// import 'package:flutter/foundation.dart' show kIsWeb;


// import 'dart:html' as html;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:learncode/buttons/add_sub_course.dart';
// import 'package:learncode/buttons/backbutton.dart';
// import 'package:learncode/buttons/delete_button.dart';
// import 'package:learncode/buttons/enroll_button.dart';
// import 'package:learncode/buttons/update_button.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/course_add_functions.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:learncode/database/delete_funtions.dart';
// import 'package:learncode/models/course.dart';
// import 'package:learncode/screens/admin/add_course/add_course_details.dart';
// import 'package:learncode/screens/admin/add_course/add_course_thumbnail.dart';
// import 'package:learncode/screens/admin/add_course/add_sub_couse_thumbnail.dart';
// import 'package:learncode/screens/admin/update_corse.dart/update_course_details.dart';
// import 'package:learncode/screens/user/provider/enrolled_course_provider.dart';
// import 'package:learncode/screens/user/widgets/enrolling_alert.dart';
// import 'package:learncode/screens/user/widgets/sub_course_tile_widget.dart';
// import 'package:flutter/foundation.dart';
// // Conditional import based on the platform
// import 'package:flutter/foundation.dart' show kIsWeb;

// if (kIsWeb) {
//  import 'dart:ui_web;
// } 



// class AdminTutorialMainPageDetails extends StatefulWidget {
//   final String introVideo;
//   final String tutorialTitle;
//   final String description;
//   final int id;
//   final int index;
//   final String courseImage;
//   final bool isAdmin;
//   final Course course;
//   const AdminTutorialMainPageDetails({
//     super.key,
//     required this.introVideo,
//     required this.tutorialTitle,
//     required this.description,
//     required this.id,
//     required this.index,
//     required this.courseImage,
//     this.isAdmin = false,
//     required this.course,
//   });
//   static int playlistCount = 0;
//   static int mainCourseId = 0;
//   @override
//   State<AdminTutorialMainPageDetails> createState() =>
//       _AdminTutorialMainPageDetailsState();
// }


// class _AdminTutorialMainPageDetailsState
//     extends State<AdminTutorialMainPageDetails> {
//   late FlickManager flickManager;
//   ValueNotifier<List<SubCourse>> filteredSubCoursesNotifier = ValueNotifier([]);
  

//   @override
//   void initState() {
//     filterPlaylist(widget.id);

//     AdminTutorialMainPageDetails.mainCourseId = widget.id;

//     getAllEnrolledCourse();
// if (kIsWeb) {
//   // final videoId = 'video_view';
//   //     final base64String = widget.introVideo; // Assuming `introVideo` is a base64 encoded string

//   //     // Register the view factory for the video element
//   //     platformViewRegistry.registerViewFactory(videoId, (int viewId) {
//   //       final videoElement = html.VideoElement()
//   //         ..src = widget.introVideo
//   //         ..controls = true
//   //         ..autoplay = false
//   //         ..style.width = '100%'
//   //         ..style.height = '100%';
//   //      log(widget.introVideo);
//   //       return videoElement;
//   //     });
//   //     flickManager = FlickManager(
//   //     autoPlay: false,
//   //       videoPlayerController: VideoPlayerController.network('data:video/mp4;base64,$base64String')
      
//   //       ..initialize().then((_) {
//   //         setState(() {});
//   //       }).catchError((error) {
//   //         return null;
//   //       }),
//   //   );
// }else{
//   flickManager = FlickManager(
//       autoPlay: false,
//       videoPlayerController: 
//       VideoPlayerController.file(File(widget.introVideo))
      
//         ..initialize().then((_) {
//           setState(() {});
//         }).catchError((error) {
//           return null;
//         }),
//     );
// }




//     super.initState();
//     // flickManager = FlickManager(
//     //   autoPlay: false,
//     //   videoPlayerController: kIsWeb?
//     //   VideoPlayerController.file(File(widget.introVideo)):
//     //  /  MemoryImage(base64Decode(widget.introVideo))
//     //     ..initialize().then((_) {
//     //       setState(() {});
//     //     }).catchError((error) {
//     //       return null;
//     //     }),
//     // );

//     fetchSubCourses(widget.tutorialTitle);
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     filteredSubCoursesNotifier.dispose();
//     super.dispose();
//   }

//   Future<void> fetchSubCourses(String courseName) async {
//     List<SubCourse> allSubCourses = await getAllSubCourses();

//     filteredSubCoursesNotifier.value = allSubCourses
//         .where((subCourse) => subCourse.courseId == widget.id)
//         .toList();
//     filteredSubCoursesNotifier.value
//         .forEach((subCourse) => print(subCourse.subCourseTitle));
//   }

//   Future<List<SubCourse>> getAllSubCourses() async {
//     final box = await Hive.openBox<SubCourse>('AddNewSubCourse');
//     return box.values.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     getAllSubCourses();
//     fechingSubcourse();
//     filterPlaylist(widget.id);
//     final enrolledProvider = EnrolledCourseProvider.of(context);
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomBackButton(
//                         buttonColor: buttonGrey,
//                         iconColor: themeTextColor,
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         }),
//                     const Text(
//                       'Details',
//                       style: tutorialPageTitletextStyle,
//                     ),
//                     widget.isAdmin
//                         ? const SizedBox()
//                         : enrolledProvider.isExist(widget.course)
//                             ? Container(
//                                 width: ScreenSize.widthMed * 0.2,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                     gradient: themePurple,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: const Center(
//                                     child: Text(
//                                   'enrolled',
//                                   style: TextStyle(
//                                       color: whiteColor,
//                                       fontWeight: FontWeight.w600),
//                                 )),
//                               )
//                             : EnrollButton(onPressed: () {
//                                 filterPlaylist(widget.id);
//                                 showDialog(
//                                     context: context,
//                                     builder: (ctx) => EnrollingAlert(
//                                           progressPoint: 2,
//                                           totalPoint:
//                                               AdminTutorialMainPageDetails
//                                                   .playlistCount,
//                                           courseId: widget.id,
//                                           course: widget.course,
//                                         ));
//                               }),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: SizedBox(
//                   width: ScreenSize.widthMed * 0.9,
//                   height: ScreenSize.heightMed * 0.26,
//                   child:kIsWeb?
//                   const HtmlElementView(
//                             viewType: 'video_view',
//                           ):
//                    FlickVideoPlayer(flickManager: flickManager),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.tutorialTitle,
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       widget.description,
//                       style: const TextStyle(fontSize: 17),
//                     ),
//                     const SizedBox(height: 30),
//                     ValueListenableBuilder<List<SubCourse>>(
//                       valueListenable: filteredSubCoursesNotifier,
//                       builder: (context, filteredSubCourses, child) {
//                         if (filteredSubCourses.isEmpty) {
//                           return SizedBox(
//                               width: ScreenSize.widthMed,
//                               height: ScreenSize.widthMed * 0.5,
//                               child: const Center(
//                                   child: Text('No SubCourse Available')));
//                         }
//                         return GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             mainAxisExtent: 230,
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 20,
//                           ),
//                           itemCount: filteredSubCourses.length,
//                           itemBuilder: (ctx, index) {
//                             return InkWell(
//                               child: SubTutorialTileWidget(
//                                 courseId: widget.id,
//                                 course: widget.course,
//                                 isAdmin: widget.isAdmin,
//                                 subCourse: filteredSubCourses,
//                                 index: index,
//                                 courseint: widget.index,
//                                 subcourseImage: filteredSubCourses[index]
//                                     .subCourseThumbnailPath,
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     widget.isAdmin == true
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               AddSubCourseButton(
//                                 title: '+ add sub course',
//                                 onPressed: () async {
//                                   await Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (ctx) => AddSubCourseThumbnail(
//                                         indexCourse: widget.index,
//                                         course: courseNotifier.value[widget.id],
//                                         courseNamee: widget.tutorialTitle,
//                                       ),
//                                     ),
//                                   );
//                                   fetchSubCourses(widget.tutorialTitle);
//                                 },
//                               ),
//                             ],
//                           )
//                         : const SizedBox(),
//                     const SizedBox(height: 15),
//                     widget.isAdmin == true
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               DeleteButton(
//                                 onPressed: () {
//                                   showDialog(
//                                       context: context,
//                                       builder: (ctx) {
//                                         return AlertDialog(
//                                           content: const Text(
//                                             'are you sure to remove this course',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: const Text(
//                                                   'cancel',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 )),
//                                             TextButton(
//                                                 onPressed: () {
//                                                   deleteCourse(widget.id);
//                                                   Navigator.of(context).pop();
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: const Text(
//                                                   'delete',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                                 )),
//                                           ],
//                                         );
//                                       });
//                                 },
//                               ),
//                               UpdateButton(onpressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (ctx) => UpdateCourseDetails(
//                                           courseTitle: widget.tutorialTitle,
//                                           courseIndex: widget.index,
//                                           courseDiscription: widget.description,
//                                           courseImage: widget.courseImage,
//                                           courseVideo: widget.introVideo,
//                                         ));
//                               }),
//                             ],
//                           )
//                         : const SizedBox()
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<int> filterPlaylist(int courseId) async {
//   int count = 0;
//   List<SubCourse> subCourses =
//       subCourseNotifier.value.where((sub) => sub.courseId == courseId).toList();
//   log('SubCourses found: ${subCourses.length} for Course ID: $courseId');
//   for (var subCourse in subCourses) {
//     log('SubCourse ID: ${subCourse.courseId}, SubCourse Title: ${subCourse.subCourseTitle}');
//     if (subCourse.tutorialPlayList.isNotEmpty) {
//       log('Playlist found with length: ${subCourse.tutorialPlayList.length}');
//       count += subCourse.tutorialPlayList.length;
//     } else {
//       log('No playlists found for SubCourse: ${subCourse.subCourseTitle}');
//     }
//   }
//   log('Total Playlists under course $courseId: ${count}');
//   AdminTutorialMainPageDetails.playlistCount = count;
//   print('count === ${AdminTutorialMainPageDetails.playlistCount}');
//   return count;
// }


