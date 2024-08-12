import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:video_player/video_player.dart';

class AddCourseDetails extends StatefulWidget {
  const AddCourseDetails({super.key});

  @override
  State<AddCourseDetails> createState() => _AddCourseDetailsState();
}

class _AddCourseDetailsState extends State<AddCourseDetails> {
  VideoPlayerController? _videoController;
  XFile? pickedVideo;
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                color: Colors.grey[200], 
              ),
              child: pickedVideo != null
                  ? _videoController != null &&
                          _videoController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
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
                  blurRadius: 5,
                  offset: Offset(0, 2),
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
                  blurRadius: 5,
                  offset: Offset(0, 2),
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
    final XFile? selectedVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo != null) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(File(selectedVideo.path))
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
      setState(() {
        pickedVideo = selectedVideo;
      });
    }
  }
}
