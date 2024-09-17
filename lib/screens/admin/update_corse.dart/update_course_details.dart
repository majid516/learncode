// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:learncode/buttons/submit_button.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:learncode/screens/web_screen/add_course_details_web.dart';
// import 'package:video_player/video_player.dart';

// // ignore: must_be_immutable
// class UpdateCourseDetails extends StatefulWidget {
//   String courseTitle;
//   int courseIndex;
//   String courseDiscription;
//   String courseImage;
//   String courseVideo;

//   UpdateCourseDetails({
//     super.key,
//     required this.courseTitle,
//     required this.courseIndex,
//     required this.courseDiscription,
//     required this.courseImage,
//     required this.courseVideo,
//   });

//   static String? updatedthumbnail;
//   static XFile? pickedVideo;

//   @override
//   State<UpdateCourseDetails> createState() => _UpdateCourseDetailsState();
// }

// class _UpdateCourseDetailsState extends State<UpdateCourseDetails> {
//   final ImagePicker picker = ImagePicker();
//   late VideoPlayerController _videoController;

//   final titleController = TextEditingController();
//   final discriptionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     titleController.text = widget.courseTitle;
//     discriptionController.text = widget.courseDiscription;

//     _videoController = VideoPlayerController.file(File(widget.courseVideo))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Text(
//               'Update',
//               style: tutorialPageTitletextStyle,
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: ScreenSize.widthMed * 0.75,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadiusDirectional.circular(12),
//                 border: Border.all(width: 0.2),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromARGB(95, 0, 0, 0),
//                     blurRadius: 2,
//                     offset: Offset(0, 1),
//                   ),
//                 ],
//               ),
//               child: TextFormField(
//                 controller: titleController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(borderSide: BorderSide.none)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('data'),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: pickImageFromGallery,
//               child: Container(
//                 width: ScreenSize.widthMed * 0.4,
//                 height: ScreenSize.widthMed * 0.3,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                     image: UpdateCourseDetails.updatedthumbnail != null
//                         ? FileImage(File(UpdateCourseDetails.updatedthumbnail!))
//                         : FileImage(File(widget.courseImage)),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('data'),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: pickVideoFromGallery,
//               child: Container(
//                 width: ScreenSize.widthMed * 0.4,
//                 height: ScreenSize.widthMed * 0.3,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.grey[200],
//                 ),
//                 child: AddCourseDetails.pickedVideo != null
//                     ? AspectRatio(
//                         aspectRatio: _videoController.value.aspectRatio,
//                         child: VideoPlayer(_videoController),
//                       )
//                     : AspectRatio(
//                         aspectRatio: 1 / 1,
//                         child: VideoPlayer(_videoController),
//                       ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('data'),
//             const SizedBox(height: 20),
//             Container(
//               width: ScreenSize.widthMed * 0.75,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadiusDirectional.circular(12),
//                 border: Border.all(width: 0.2),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromARGB(95, 0, 0, 0),
//                     blurRadius: 2,
//                     offset: Offset(0, 1),
//                   ),
//                 ],
//               ),
//               child: TextFormField(
//                 controller: discriptionController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(borderSide: BorderSide.none)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text('data'),
//             const SizedBox(height: 20),
//             SubmitButton(
//               onPressed: () {
//                 final thumbnailToUpdate =
//                     UpdateCourseDetails.updatedthumbnail ?? widget.courseImage;

//                 updateCouse(
//                   widget.courseIndex,
//                   titleController.text,
//                   discriptionController.text,
//                   thumbnailToUpdate,
//                   AddCourseDetails.pickedVideo!.path,
//                 );
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void pickVideoFromGallery() async {
//     final XFile? selectedVideo =
//         await picker.pickVideo(source: ImageSource.gallery);
//     if (selectedVideo != null) {
//       _videoController.dispose();

//       _videoController = VideoPlayerController.file(File(selectedVideo.path))
//         ..initialize().then((_) {
//           setState(() {});
//           _videoController.play();
//         });

//       setState(() {
//         AddCourseDetails.pickedVideo = selectedVideo;
//       });
//     }
//   }

//   Future<void> pickImageFromGallery() async {
//     final XFile? selectedImage =
//         await picker.pickImage(source: ImageSource.gallery);
//     if (selectedImage != null) {
//       setState(() {
//         UpdateCourseDetails.updatedthumbnail = selectedImage.path;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }
// }
