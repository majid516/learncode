import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:video_player/video_player.dart';

class AdminSubTutorialDetailPage extends StatefulWidget {
  final String video;
  final String tutorialTitle;
  final int courseindex;
    final int subCourseindex;
    final int playlistIndex;


  const AdminSubTutorialDetailPage({
    super.key,
    required this.video,
    required this.tutorialTitle, required this.courseindex, required this.subCourseindex, required this.playlistIndex,
    
  });

  @override
  State<AdminSubTutorialDetailPage> createState() => _TutorialMainPageDetailsState();
}

class _TutorialMainPageDetailsState extends State<AdminSubTutorialDetailPage> {
  late FlickManager flickManager;
  Duration? videoDuration;

  @override
  void initState() {
    super.initState();
    final videoPlayerController = VideoPlayerController.asset(widget.video);
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController
        ..initialize().then((_) {
          // Set the duration once the video is initialized
          if (mounted) {
            setState(() {
              videoDuration = videoPlayerController.value.duration;
            });
          }
        }).catchError((error) {
         return null;
        }),
    );

    // Add a listener to update duration when the video player is initialized
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isInitialized && videoDuration == null) {
        if (mounted) {
          setState(() {
            videoDuration = videoPlayerController.value.duration;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 25, right: 25, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(
                          buttonColor: buttonGrey,
                          iconColor: themeTextColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                       const   SizedBox(width: 120,),
                       const Text(
                        'Details',
                        style: tutorialPageTitletextStyle,
                      ),
                      
                    ],
                  ),
                ),
               const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: ScreenSize.widthMed * 0.9,
                    height: ScreenSize.widthMed * 0.52,
                    child: FlickVideoPlayer(flickManager: flickManager),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const  Text(
                        'Introduction',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: themeTextColor),
                      ),
                     const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(videoDuration != null
                            ? 'Duration : ${_findDuration(videoDuration!)}'
                            : 'loading..'),
                      ),
                     const SizedBox(height: 10),
                     const Text(
                        'Notes',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: themeTextColor),
                      ),
                      ValueListenableBuilder(valueListenable: courseNotifier, builder: (ctx,newNotes,child){
                          return ListView.builder(
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return  ExpansionTile(
                            maintainState: false,
                            title: Text(newNotes[widget.courseindex].courseDetails!.subCourse![widget.subCourseindex].tutorialPlayList![widget.playlistIndex].subCourseDetails!.questionNotes!.questions[index]),
                            children: [
                              Text(
                                newNotes[widget.courseindex].courseDetails!.subCourse![widget.subCourseindex].tutorialPlayList![widget.playlistIndex].subCourseDetails!.questionNotes!.answers[index],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          );
                        },
                        itemCount: newNotes[widget.courseindex].courseDetails!.subCourse![widget.subCourseindex].tutorialPlayList![widget.playlistIndex].subCourseDetails!.questionNotes!.questions.length,
                      );
                      })
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _findDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minute = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inSeconds.remainder(60));
    return '$minute : $second';
  }
}

