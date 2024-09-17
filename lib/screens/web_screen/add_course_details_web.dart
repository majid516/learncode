import 'dart:html' as html;
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddCourseDetails extends StatefulWidget {
  const AddCourseDetails({super.key});
  static XFile? pickedVideo;
  static final courseDiscriptionController = TextEditingController();
  static  String? videoElementId;
  @override
  State<AddCourseDetails> createState() => _AddCourseDetailsState();
}

class _AddCourseDetailsState extends State<AddCourseDetails> {
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                pickVideoFromGallery();
              },
              child: Container(
                width: ScreenSize.widthMed*0.25,
                height: ScreenSize.widthMed * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: AddCourseDetails.pickedVideo != null
                    ? AddCourseDetails.videoElementId != null
                        ? HtmlElementView(viewType:AddCourseDetails.videoElementId!)
                        : const Center(child: CircularProgressIndicator())
                    : const Center(
                        child: Text('No video selected'),
                      ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Add course introduction video',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                controller: AddCourseDetails.courseDiscriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Add course description',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
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
          // Register the video element for the HtmlElementView
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
            AddCourseDetails.videoElementId = videoId;
            AddCourseDetails.pickedVideo = XFile(file.name);
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
}
