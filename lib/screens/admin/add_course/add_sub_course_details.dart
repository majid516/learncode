import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:video_player/video_player.dart';

class AddSubCourseDetails extends StatefulWidget {
  const AddSubCourseDetails({super.key});
 static  VideoPlayerController? videoController;
 static  XFile? pickedVideo;

  @override
  State<AddSubCourseDetails> createState() => _AddSubCourseDetailsState();
}

class _AddSubCourseDetailsState extends State<AddSubCourseDetails> {
  ImageProvider<Object>? thumbnail;
 
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
   AddSubCourseDetails.videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          children: [
           
            
            InkWell(
              onTap: () {
                pickVideoFromGallery();
              },
              child: Container(
                width: ScreenSize.widthMed * 0.4,
                height: ScreenSize.widthMed * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200], // Placeholder color
                ),
                child: AddSubCourseDetails.pickedVideo != null
                    ?AddSubCourseDetails. videoController != null &&
                            AddSubCourseDetails.videoController!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:AddSubCourseDetails. videoController!.value.aspectRatio,
                            child: VideoPlayer(AddSubCourseDetails.videoController!),
                          )
                        : const Center(child: CircularProgressIndicator())
                    : const Center(
                        child: Text('No video selected'),
                      ),
              ),
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.02,
            ),
            const Text(
              'add course thumbnail',
              style: addTutorialPagestyle,
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.03,
            ),
            Container(
              width: ScreenSize.widthMed * 0.8,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.02,
            ),
            const Text(
              'add course title',
              style: addTutorialPagestyle,
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.04,
            ),
            Container(
              width: ScreenSize.widthMed * 0.8,
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.02,
            ),
            const Text(
              'add course description',
              style: addTutorialPagestyle,
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.05,
            ),
          ],
        ),
      
    );
  }

  void pickVideoFromGallery() async {
     XFile? selectedVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo != null) {
     AddSubCourseDetails. videoController?.dispose();
      AddSubCourseDetails.videoController  = VideoPlayerController.file(File(selectedVideo.path))
        ..initialize().then((_) {
          setState(() {});
         AddSubCourseDetails. videoController!.play();
        });
      setState(() {
        AddSubCourseDetails.pickedVideo = selectedVideo;
      });
    }
  }

  void pickImagefromGallery() async {
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        thumbnail = FileImage(File(selectedImage.path));
      });
    }
  }
}
