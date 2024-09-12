import 'dart:io';
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
      AddPlaylistTitle.videoControllers = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add course playlist ',
        style: accountPagetextStyle,
      )),
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
                  width: ScreenSize.widthMed * 0.9,
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
                SizedBox(
                  height: ScreenSize.heightMed * 0.02,
                ),
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
                    width: ScreenSize.widthMed * 0.4,
                    height: ScreenSize.widthMed * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
                    ),
                    child: AddPlaylistTitle.pickedVideo != null
                        ? AddPlaylistTitle.videoControllers != null &&
                                AddPlaylistTitle
                                    .videoControllers!.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: AddPlaylistTitle
                                    .videoControllers!.value.aspectRatio,
                                child: VideoPlayer(
                                    AddPlaylistTitle.videoControllers!),
                              )
                            : const Center(child: CircularProgressIndicator())
                        : const Center(
                            child: Text('No video selected'),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Add playlist video',
                  style: addTutorialPagestyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                SubmitButton(
                  onPressed: () async {
                    final subTitle = playListTitleController.text.trim();
                    if (subTitle.isNotEmpty && widget.subCourseId != null) {
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
                            content: Text('add plalist title and video')),
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
    final XFile? selectedVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo != null) {
      if (AddPlaylistTitle.videoControllers != null) {
        AddPlaylistTitle.videoControllers!.dispose();
        AddPlaylistTitle.videoControllers = null;
      }

      AddPlaylistTitle.videoControllers =
          VideoPlayerController.file(File(selectedVideo.path))
            ..initialize().then((_) {
              if (mounted) {
                setState(() {
                  AddPlaylistTitle.pickedVideo = selectedVideo;
                  AddPlaylistTitle.videoControllers!.play();
                });
              }
            }).catchError((error) {
              // print('Error initializing video: $error');
            });
    }
  }
}
