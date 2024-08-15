// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:learncode/buttons/backbutton.dart';
// import 'package:learncode/buttons/like_button.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:video_player/video_player.dart';

// class UserSubTutorialDetailPage extends StatefulWidget {
//   final String video;
//   final String tutorialTitle;

//   const UserSubTutorialDetailPage({
//     super.key,
//     required this.video,
//     required this.tutorialTitle,
//   });

//   @override
//   State<UserSubTutorialDetailPage> createState() =>
//       _TutorialMainPageDetailsState();
// }

// class _TutorialMainPageDetailsState extends State<UserSubTutorialDetailPage> {
//   late FlickManager flickManager;
//   Duration? videoDuration;

//   @override
//   void initState() {
//     super.initState();
//     final videoPlayerController = VideoPlayerController.asset(course.courseDetails!.subCourse![0].tutorialPlayList![0].subCourseDetails!.subCourseVideo,);
//     flickManager = FlickManager(
//       videoPlayerController: videoPlayerController
//         ..initialize().then((_) {
//           setState(() {
//             videoDuration = videoPlayerController.value.duration;
//           });
//         }).catchError((error) {
//           return null;
//         }),
//     );
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 40.0, left: 25, right: 25, bottom: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomBackButton(
//                           buttonColor: buttonGrey,
//                           iconColor: themeTextColor,
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           }),
//                       const Text(
//                         'Details',
//                         style: tutorialPageTitletextStyle,
//                       ),
//                       CustomLikeButton(
//                           buttonColor: buttonGrey,
//                           onPressed: () {},
//                           iconColor: themeTextColor)
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: SizedBox(
//                     width: ScreenSize.widthMed * 0.9,
//                     height: ScreenSize.widthMed * 0.52,
//                     child: FlickVideoPlayer(flickManager: flickManager),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Introduction',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: themeTextColor),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Text(videoDuration != null
//                             ? 'Duration : ${_findDuration(videoDuration!)}'
//                             : 'loading..'),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         'Notes',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: themeTextColor),
//                       ),
//                       // ListView.builder(
//                       //   physics: const NeverScrollableScrollPhysics(),
//                       //   shrinkWrap: true,
//                       //   itemBuilder: (ctx, index) {
//                       //     return  ExpansionTile(
//                       //       // title: Text(course.courseDetails!.subCourse![0].tutorialPlayList![0].subCourseDetails!.questionNotes![0].subCourseQuestion),
//                       //       // children: [
//                       //       //   Text(
//                       //       //     course.courseDetails!.subCourse![0].tutorialPlayList![0].subCourseDetails!.questionNotes![0].subCourseAnswer,
//                       //       //     style: TextStyle(fontSize: 15),
//                       //       //   ),
//                       //       // ],
//                       //     );
//                       //   },
//                       //   itemCount: 10,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _findDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minute = twoDigits(duration.inMinutes.remainder(60));
//     final second = twoDigits(duration.inSeconds.remainder(60));
//     return '$minute : $second';
//   }
// }
