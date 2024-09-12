import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';

import 'package:learncode/screens/admin/add_course/add_playlist_title.dart';
import 'package:video_player/video_player.dart';

class UpdatePlaylist extends StatefulWidget {
  final int playlistId;
  final String subVideo;
  final String playlistName;
  const UpdatePlaylist(
      {super.key,
      required this.playlistId,
      required this.subVideo,
      required this.playlistName});

  @override
  State<UpdatePlaylist> createState() => _UpdatePlaylistState();
}

final playListUpdatedTitleController = TextEditingController();
ImagePicker picker = ImagePicker();
VideoPlayerController? updatedvideoController;

class _UpdatePlaylistState extends State<UpdatePlaylist> {
  @override
  Widget build(BuildContext context) {
    playListUpdatedTitleController.text = widget.playlistName;
    return AlertDialog(
      content: SizedBox(
        height: ScreenSize.heightMed * 0.5,
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
                controller: playListUpdatedTitleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.02,
            ),
            const Text(
              'update Sub Course Title',
              style: addTutorialPagestyle,
            ),
            const SizedBox(height: 30),
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
                    ? AspectRatio(
                        aspectRatio:AddPlaylistTitle.videoControllers!.value.aspectRatio,
                        child: VideoPlayer(AddPlaylistTitle.videoControllers!),
                      )
                    : AspectRatio(
                        aspectRatio: 1 / 1,
                        child: VideoPlayer(VideoPlayerController.file(File(widget.subVideo))),
                      ),
              ),
            ),
            SizedBox(
              height: ScreenSize.heightMed * 0.02,
            ),
            const Text(
              'update Sub Course video',
              style: addTutorialPagestyle,
            ),
            const SizedBox(
              height: 30,
            ),
            SubmitButton(onPressed: () async {
              updatePlaylist(
                  widget.playlistId,
                  playListUpdatedTitleController.text,
                  AddPlaylistTitle.pickedVideo!.path);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }),
          ],
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
            }).catchError((error) {});
    }
  }
}
