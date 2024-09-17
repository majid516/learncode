import 'dart:html' as html;
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/course_add_functions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';
import 'package:video_player/video_player.dart';

class AddPlaylistTitle extends StatefulWidget {
  final int? subCourseId;
  final int playlistId;
  final int courseId;

  static List<TutorialPlayList> playlistList = [];
  static VideoPlayerController? videoControllers;

  const AddPlaylistTitle({
    super.key,
    this.subCourseId,
    required this.playlistId,
    required this.courseId,
  });

  static XFile? pickedVideo;
  static String? videoElementId;

  @override
  State<AddPlaylistTitle> createState() => _AddPlaylistTitleState();
}

class _AddPlaylistTitleState extends State<AddPlaylistTitle> {
  final playListTitleController = TextEditingController();
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    if (AddPlaylistTitle.videoControllers != null) {
      AddPlaylistTitle.videoControllers!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add course playlist',
          style: accountPagetextStyle,
        ),
      ),
      body: SizedBox(
        width: ScreenSize.widthMed,
        height: ScreenSize.heightMed,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: ScreenSize.heightMed * 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    controller: playListTitleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(height: ScreenSize.heightMed * 0.02),
                const Text(
                  'Add playlist Title',
                  style: addTutorialPagestyle,
                ),
                const SizedBox(height: 40),
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
                    child: AddPlaylistTitle.pickedVideo != null &&
                            AddPlaylistTitle.videoElementId != null
                        ? HtmlElementView(viewType: AddPlaylistTitle.videoElementId!)
                        : const Center(
                            child: Text('No video selected'),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add playlist video',
                  style: addTutorialPagestyle,
                ),
                const SizedBox(height: 30),
                SubmitButton(
                  onPressed: () async {
                    final subTitle = playListTitleController.text.trim();
                    if (subTitle.isNotEmpty &&
                        widget.subCourseId != null &&
                        AddPlaylistTitle.pickedVideo != null) {
                      final data = TutorialPlayList(
                        playlistId: widget.playlistId,
                        playListTitle: subTitle,
                        subCourseId: widget.subCourseId!,
                        subCourseDetails: SubCourseDetails(
                          subCourseVideo: AddPlaylistTitle.pickedVideo!.path,
                        ),
                      );
                      await addPlayList(data);
                      updatePlaylistCount(widget.courseId, 0);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 192, 32, 21),
                          content: Text('Add playlist title and video'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
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
          platformViewRegistry.registerViewFactory(videoId, (int viewId) {
            final videoElement = html.VideoElement()
              ..src = html.Url.createObjectUrl(file)
              ..autoplay = false
              ..controls = true
              ..style.width = '100%'
              ..style.height = '100%';
              
            return videoElement;
          });

          setState(() {
            AddPlaylistTitle.videoElementId = videoId;
            AddPlaylistTitle.pickedVideo = XFile(file.name);
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
}
