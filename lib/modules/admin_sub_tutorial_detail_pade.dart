import 'dart:io';
import 'dart:math';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/add_sub_course.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/buttons/favourite_button.dart';
import 'package:learncode/buttons/next_buttton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_notes.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_playlist.dart';
import 'package:learncode/screens/admin/widgets/delete_alert.dart';
import 'package:learncode/screens/user/provider/favourite_provider.dart';
import 'package:video_player/video_player.dart';

class AdminSubTutorialDetailPage extends StatefulWidget {
  final String subVideo;
  final String tutorialTitle;
  final int? courseindex;
  final int subCourseindex;
  final int playlistIndex;
  final String playListName;
  final bool isAdmin;
  final int subcourseId;
  final int playlistId;
  final List<TutorialPlayList>?  listOFPLaylist;
  final TutorialPlayList playlist;
  final TutorialPlayList? nextPlaylist;
   AdminSubTutorialDetailPage({
    super.key,
    required this.subVideo,
    required this.tutorialTitle,
    this.courseindex,
    required this.subCourseindex,
    required this.playlistIndex,
    required this.playListName,
    required this.isAdmin,
    required this.subcourseId,
    required this.playlistId,
    required this.playlist,
    this.nextPlaylist, 
     this.listOFPLaylist,
  });

  @override
  State<AdminSubTutorialDetailPage> createState() =>
      _TutorialMainPageDetailsState();
}

class _TutorialMainPageDetailsState extends State<AdminSubTutorialDetailPage> {
  late FlickManager flickManager;
  Duration? videoDuration;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _loadNotes();
    currentIndex = widget.playlistIndex;  

  }
  void _goToNextPlaylist() {
    if (currentIndex < widget.listOFPLaylist!.length - 1) {
      setState(() {
        currentIndex += 1;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => AdminSubTutorialDetailPage(
          listOFPLaylist: widget.listOFPLaylist,
          playlist: widget.listOFPLaylist![currentIndex],
          subVideo: widget.listOFPLaylist![currentIndex].subCourseDetails!.subCourseVideo,
          tutorialTitle: widget.tutorialTitle,
          subCourseindex: widget.subCourseindex,
          playlistIndex: currentIndex,
          playListName: widget.listOFPLaylist![currentIndex].playListTitle,
          isAdmin: widget.isAdmin,
          subcourseId: widget.subcourseId,
          playlistId: widget.listOFPLaylist![currentIndex].playlistId,
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No more playlists available.")),
      );
    }
  }

  Future<void> _initializeVideo() async {
    final videoPlayerController =
        VideoPlayerController.file(File(widget.subVideo));
    flickManager = FlickManager(
      autoPlay: false,
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
        .where((note) => note.playlistId == widget.playlistId)
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
    final favoriteProvider = FavouriteProvider.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        buttonColor: buttonGrey,
                        iconColor: themeTextColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const Text(
                      'Details',
                      style: tutorialPageTitletextStyle,
                    ),
                    widget.isAdmin
                        ? PopupMenuButton<void>(
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 40,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem<void>(
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => UpdatePlaylist(
                                                playlistId: widget.playlistId,
                                                subVideo: widget.subVideo,
                                                playlistName:
                                                    widget.playListName,
                                              ));
                                    },
                                    child: const Text(
                                      'update',
                                      style: TextStyle(
                                          color: themeTextColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                              PopupMenuItem<void>(
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => DeleteAlert(
                                              message:
                                                  'do you ready to remove this permenently',
                                              deleteOnPressed: () {
                                                deletePlaylist(
                                                    widget.playlistId);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              cancelOnpressed: () =>
                                                  Navigator.of(context).pop()));
                                    },
                                    child: const Text(
                                      'delete',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                            ],
                          )
                        : FavouriteButton(
                            buttonColor: buttonGrey,
                            onPressed: () {
                              favoriteProvider.toggleFavourite(widget.playlist);
                            },
                            icon: Icon(
                              favoriteProvider.isExist(widget.playlist)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                  ],
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
                          if (notes.isEmpty) {
                            return SizedBox(
                                width: ScreenSize.widthMed,
                                height: ScreenSize.heightMed * 0.3,
                                child: const Center(
                                    child: Text('No Notes Availabe')));
                          } else {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: notes.length,
                                itemBuilder: (ctx, noteIndex) {
                                  final note = notes[noteIndex];

                                  return Column(
                                    children: List.generate(
                                      note.questions.length,
                                      (i) {
                                        if (i < note.answers.length) {
                                          return ExpansionTile(
                                            title: Text(
                                              note.questions[i],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            children: [
                                              ListTile(
                                                  title: Text(note.answers[i])),
                                            ],
                                          );
                                        } else {
                                          return const ExpansionTile(
                                            title:
                                                Text("Question without answer"),
                                            children: [
                                              ListTile(
                                                  title: Text(
                                                      "No answer available")),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.isAdmin == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddSubCourseButton(
                      title: '+ add notes',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AddNotes(
                                  playListId: widget.playlistId,
                                )));
                      }),
                ],
              )
             
            : NextButtton(
                onPressed: () {
                  _goToNextPlaylist();
                },
      )));
  }

  String _findDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minute = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inSeconds.remainder(60));
    return '$minute : $second';
  }
}


















































// import 'dart:io';

// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:learncode/buttons/add_sub_course.dart';
// import 'package:learncode/buttons/backbutton.dart';
// import 'package:learncode/buttons/favourite_button.dart';
// import 'package:learncode/buttons/next_buttton.dart';
// import 'package:learncode/constants/constants.dart';
// import 'package:learncode/constants/mediaquery.dart';
// import 'package:learncode/database/database_funtions.dart';
// import 'package:learncode/models/course.dart';
// import 'package:learncode/screens/admin/add_course/add_notes.dart';
// import 'package:learncode/screens/admin/update_corse.dart/update_playlist.dart';
// import 'package:learncode/screens/admin/widgets/delete_alert.dart';
// import 'package:learncode/screens/user/provider/favourite_provider.dart';
// import 'package:video_player/video_player.dart';

// class AdminSubTutorialDetailPage extends StatefulWidget {
//   final String subVideo;
//   final String tutorialTitle;
//   final int? courseindex;
//   final int subCourseindex;
//   final int playlistIndex;
//   final String playListName;
//   final bool isAdmin;
//   final int subcourseId;
//   final int playlistId;
//   final List<TutorialPlayList>?  listOFPLaylist;
//   final TutorialPlayList playlist;
//   final TutorialPlayList? nextPlaylist;
//    AdminSubTutorialDetailPage({
//     super.key,
//     required this.subVideo,
//     required this.tutorialTitle,
//     this.courseindex,
//     required this.subCourseindex,
//     required this.playlistIndex,
//     required this.playListName,
//     required this.isAdmin,
//     required this.subcourseId,
//     required this.playlistId,
//     required this.playlist,
//     this.nextPlaylist, 
//      this.listOFPLaylist,
//   });

//   @override
//   State<AdminSubTutorialDetailPage> createState() =>
//       _TutorialMainPageDetailsState();
// }

// class _TutorialMainPageDetailsState extends State<AdminSubTutorialDetailPage> {
//   late FlickManager flickManager;
//   Duration? videoDuration;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//     _loadNotes();
//   }

//   Future<void> _initializeVideo() async {
//     final videoPlayerController =
//         VideoPlayerController.file(File(widget.subVideo));
//     flickManager = FlickManager(
//       autoPlay: false,
//       videoPlayerController: videoPlayerController
//         ..initialize().then((_) {
//           if (mounted) {
//             setState(() {
//               videoDuration = videoPlayerController.value.duration;
//             });
//           }
//         }).catchError((error) {
//           return null;
//         }),
//     );

//     videoPlayerController.addListener(() {
//       if (videoPlayerController.value.isInitialized && videoDuration == null) {
//         if (mounted) {
//           setState(() {
//             videoDuration = videoPlayerController.value.duration;
//           });
//         }
//       }
//     });
//   }

//   Future<void> _loadNotes() async {
//     final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
//     final notes = noteBox.values
//         .where((note) => note.playlistId == widget.playlistId)
//         .toList();
//     questionNoteNotifier.value = notes;
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final favoriteProvider = FavouriteProvider.of(context);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomBackButton(
//                         buttonColor: buttonGrey,
//                         iconColor: themeTextColor,
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         }),
//                     const Text(
//                       'Details',
//                       style: tutorialPageTitletextStyle,
//                     ),
//                     widget.isAdmin
//                         ? PopupMenuButton<void>(
//                             icon: const Icon(
//                               Icons.more_vert_outlined,
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               size: 40,
//                             ),
//                             itemBuilder: (context) => [
//                               PopupMenuItem<void>(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => UpdatePlaylist(
//                                                 playlistId: widget.playlistId,
//                                                 subVideo: widget.subVideo,
//                                                 playlistName:
//                                                     widget.playListName,
//                                               ));
//                                     },
//                                     child: const Text(
//                                       'update',
//                                       style: TextStyle(
//                                           color: themeTextColor,
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700),
//                                     )),
//                               ),
//                               PopupMenuItem<void>(
//                                 child: TextButton(
//                                     onPressed: () {
//                                       showDialog(
//                                           context: context,
//                                           builder: (ctx) => DeleteAlert(
//                                               message:
//                                                   'do you ready to remove this permenently',
//                                               deleteOnPressed: () {
//                                                 deletePlaylist(
//                                                     widget.playlistId);
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).pop();
//                                               },
//                                               cancelOnpressed: () =>
//                                                   Navigator.of(context).pop()));
//                                     },
//                                     child: const Text(
//                                       'delete',
//                                       style: TextStyle(
//                                           color: Colors.red,
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700),
//                                     )),
//                               ),
//                             ],
//                           )
//                         : FavouriteButton(
//                             buttonColor: buttonGrey,
//                             onPressed: () {
//                               favoriteProvider.toggleFavourite(widget.playlist);
//                             },
//                             icon: Icon(
//                               favoriteProvider.isExist(widget.playlist)
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: Colors.red,
//                             ),
//                           ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: SizedBox(
//                     width: ScreenSize.widthMed * 0.9,
//                     height: ScreenSize.widthMed * 0.52,
//                     child: FlickVideoPlayer(flickManager: flickManager),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.playListName,
//                         style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: themeTextColor),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Text(videoDuration != null
//                             ? 'Duration : ${_findDuration(videoDuration!)}'
//                             : 'loading..'),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         'Notes',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: themeTextColor),
//                       ),
//                       ValueListenableBuilder(
//                         valueListenable: questionNoteNotifier,
//                         builder: (context, List<QuestionNotes> notes, _) {
//                           if (notes.isEmpty) {
//                             return SizedBox(
//                                 width: ScreenSize.widthMed,
//                                 height: ScreenSize.heightMed * 0.3,
//                                 child: const Center(
//                                     child: Text('No Notes Availabe')));
//                           } else {
//                             return ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: notes.length,
//                                 itemBuilder: (ctx, noteIndex) {
//                                   final note = notes[noteIndex];

//                                   return Column(
//                                     children: List.generate(
//                                       note.questions.length,
//                                       (i) {
//                                         if (i < note.answers.length) {
//                                           return ExpansionTile(
//                                             title: Text(
//                                               note.questions[i],
//                                               style: const TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                             children: [
//                                               ListTile(
//                                                   title: Text(note.answers[i])),
//                                             ],
//                                           );
//                                         } else {
//                                           return const ExpansionTile(
//                                             title:
//                                                 Text("Question without answer"),
//                                             children: [
//                                               ListTile(
//                                                   title: Text(
//                                                       "No answer available")),
//                                             ],
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   );
//                                 });
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: widget.isAdmin == true
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AddSubCourseButton(
//                       title: '+ add notes',
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (ctx) => AddNotes(
//                                   playListId: widget.playlistId,
//                                 )));
//                       }),
//                 ],
//               )
             
//             : NextButtton(
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (ctx) => AdminSubTutorialDetailPage(
//                       nextPlaylist: widget.nextPlaylist,
//                       subVideo:
//                           widget.nextPlaylist!.subCourseDetails!.subCourseVideo,
//                       tutorialTitle: widget.tutorialTitle,
//                       subCourseindex: widget.subCourseindex,
//                       playlistIndex: widget.nextPlaylist!.playlistId,
//                       playListName: widget.nextPlaylist!.playListTitle,
//                       isAdmin: widget.isAdmin,
//                       subcourseId: widget.subcourseId,
//                       playlistId: widget.nextPlaylist!.playlistId,
//                       playlist: widget.playlist,
//                     ),
//                   ));
//                 },
//       )));
//   }

//   String _findDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minute = twoDigits(duration.inMinutes.remainder(60));
//     final second = twoDigits(duration.inSeconds.remainder(60));
//     return '$minute : $second';
//   }
// }
