import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_playlist.dart';
import 'package:learncode/screens/web_screen/add_course_details_web.dart';
import 'package:learncode/screens/web_screen/update_playlist_web.dart';

class UpdateCourseDetails extends StatefulWidget {
  String courseTitle;
  int courseIndex;
  String courseDiscription;
  String courseImage;
  String courseVideo;

  UpdateCourseDetails({
    super.key,
    required this.courseTitle,
    required this.courseIndex,
    required this.courseDiscription,
    required this.courseImage,
    required this.courseVideo,
  });

  static String? updatedthumbnail;
  static String? videoElementId;
  static XFile? pickedVideo;

  @override
  State<UpdateCourseDetails> createState() => _UpdateCourseDetailsState();
}

class _UpdateCourseDetailsState extends State<UpdateCourseDetails> {
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();  // Missing picker initialization

  @override
  void initState() {
    super.initState();
    titleController.text = widget.courseTitle;
    discriptionController.text = widget.courseDiscription;
  }

  @override
  void dispose() {
    // Clean up resources and reset values when the widget is closed
    titleController.dispose();
    discriptionController.dispose();
    UpdateCourseDetails.updatedthumbnail = null;
    UpdateCourseDetails.videoElementId = null;
    UpdateCourseDetails.pickedVideo = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Update',
              style: tutorialPageTitletextStyle,
            ),
            const SizedBox(height: 20),
            Container(
              width: ScreenSize.widthMed * 0.5,
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
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: pickImageFromGallery,
              child: Container(
                width: ScreenSize.widthMed * 0.4,
                height: ScreenSize.widthMed * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: UpdateCourseDetails.updatedthumbnail != null
                        ? MemoryImage(base64Decode(UpdateCourseDetails.updatedthumbnail!))
                        : FileImage(File(widget.courseImage)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: pickVideoFromGallery,
              child: Container(
                 width: ScreenSize.widthMed*0.25,
                height: ScreenSize.widthMed * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: UpdateCourseDetails.videoElementId != null
                    ? HtmlElementView(viewType: UpdateCourseDetails.videoElementId!)
                    : HtmlElementView(viewType: widget.courseVideo),
              ),
            ),
            const SizedBox(height: 20),
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
                controller: discriptionController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 20),
            SubmitButton(
              onPressed: () {
                final thumbnailToUpdate =
                    UpdateCourseDetails.updatedthumbnail ?? widget.courseImage;

                updateCouse(
                  widget.courseIndex,
                  titleController.text,
                  discriptionController.text,
                  thumbnailToUpdate,
                  AddCourseDetails.pickedVideo!.path,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      var imageBytes = await selectedImage.readAsBytes();
      setState(() {
        UpdateCourseDetails.updatedthumbnail = base64Encode(imageBytes);
      });
    }
  }

  void pickVideoFromGallery() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'video/*';
    input.click();

    input.onChange.listen((e) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;
        final reader = html.FileReader();

        reader.onLoadEnd.listen((e) {
          final videoId = 'video_${DateTime.now().millisecondsSinceEpoch}';
          platformViewRegistry.registerViewFactory(videoId, (int viewId) {
            final videoElement = html.VideoElement()
              ..src = html.Url.createObjectUrl(file)
              ..controls = true
              ..autoplay = false
              ..style.width = '100%'
              ..style.height = '100%';

            return videoElement;
          });

          setState(() {
            UpdateCourseDetails.videoElementId = videoId;
            UpdateCourseDetails.pickedVideo = XFile(file.name);
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
}
