import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_notes.dart';
import 'package:video_player/video_player.dart';

class AdminSubTutorialDetailPage extends StatefulWidget {
  final String video;
  final String tutorialTitle;
  final int courseindex;
  final int subCourseindex;
  final int playlistIndex;
  final String playListName;

  const AdminSubTutorialDetailPage({
    super.key,
    required this.video,
    required this.tutorialTitle,
    required this.courseindex,
    required this.subCourseindex,
    required this.playlistIndex,
    required this.playListName,
  });

  @override
  State<AdminSubTutorialDetailPage> createState() =>
      _TutorialMainPageDetailsState();
}

class _TutorialMainPageDetailsState extends State<AdminSubTutorialDetailPage> {
  late FlickManager flickManager;
  Duration? videoDuration;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _loadNotes();
  }

  Future<void> _initializeVideo() async {
    final videoPlayerController = VideoPlayerController.asset(widget.video);
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              videoDuration = videoPlayerController.value.duration;
            });
          }
        }).catchError((error) {
          return null;
        }),
    );

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

  Future<void> _loadNotes() async {
    final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
    final notes = noteBox.values
        .where((note) => note.playListName == widget.playListName)
        .toList();
    questionNoteNotifier.value = notes;
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
                      const SizedBox(
                        width: 120,
                      ),
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
                      Text(
                        widget.playListName,
                        style: const TextStyle(
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
                      ValueListenableBuilder(
                        valueListenable: questionNoteNotifier,
                        builder: (context, List<QuestionNotes> notes, _) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (ctx, noteIndex) {
                              final note = notes[noteIndex];

                              // Ensure that the index is within the valid range
                              return Column(
                                children: List.generate(
                                  note.questions.length,
                                  (i) {
                                    if (i < note.answers.length) {
                                      // Check to ensure we have corresponding answers
                                      return ExpansionTile(
                                        title: Text(note.questions[i]),
                                        children: [
                                          ListTile(
                                              title: Text(note.answers[i])),
                                        ],
                                      );
                                    } else {
                                      return ExpansionTile(
                                        title: Text("Question without answer"),
                                        children: [
                                          ListTile(
                                              title:
                                                  Text("No answer available")),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => AddNotes(
                                      playListName: widget.playListName,
                                    )));
                          },
                          child: Text('Add Note')),
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
