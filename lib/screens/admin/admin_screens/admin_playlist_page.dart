import 'package:flutter/material.dart';
import 'package:learncode/buttons/add_sub_course.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/delete_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_playlist_title.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_sub_course_title.dart';
import 'package:learncode/screens/admin/widgets/delete_alert.dart';
import 'package:learncode/screens/user/widgets/playlist_list.dart';
import 'package:learncode/screens/web_screen/add_playlist_web.dart';

// ignore: must_be_immutable
class AdminPlaylistPage extends StatefulWidget {
  final int index;
  final int courseIndex;
  final int subIndex;
  final String subCourseName;
  String subImage;
  final int subCourseId;
  final bool isAdmin;
  final String subVideo;
  final int courseId;

  AdminPlaylistPage({
    super.key,
    required this.subImage,
    required this.index,
    required this.courseIndex,
    required this.subIndex,
    required this.subCourseName,
    required this.subCourseId,
    required this.isAdmin,
    required this.subVideo,
    required this.courseId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AdminPlayListPageState createState() => _AdminPlayListPageState();
  
}

List<TutorialPlayList> filteredPlaylists = [];

class _AdminPlayListPageState extends State<AdminPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    fechingPlaylist();
    final subCourseName = widget.subCourseName;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                     bool isMobile = constraints.minWidth < 600;

      double containerHieght =
          isMobile ? constraints.maxWidth * 0.2 : constraints.maxWidth * 0.2;
  
                    return Container(
                    width:ScreenSize.widthMed,
                    height: containerHieght,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'asset/image/5 Tips To Create Awesome Slideshows.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  );
                  },
                   
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(
                        buttonColor: buttonPurple,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconColor: buttonGrey,
                      ),
                      PopupMenuButton<void>(
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: whiteColor,
                          size: 40,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem<void>(
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => UpdateSubCourseTitle(
                                            subIndex: widget.subIndex,
                                            subcourseImage: widget.subImage,
                                            subTitle: subCourseName,
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
                                            deleteSubCourse(widget.subCourseId);
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
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                children: [
                  Text(
                    'Playlist',
                    style: tutorialPageTitletextStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<List<TutorialPlayList>>(
                valueListenable: playlistNotifier,
                builder: (ctx, playlists, child) {
                  filteredPlaylists = playlists
                      .where((playlist) =>
                          playlist.subCourseId == widget.subCourseId)
                      .toList();
                  if (filteredPlaylists.isEmpty) {
                    return const Center(child: Text('No Playlist Available'));
                  } else {
                    return PlaylistTab(
                      subVideo: widget.subVideo,
                      isAdmin: widget.isAdmin,
                      playlists: filteredPlaylists,
                      courseIndex: widget.courseIndex,
                      subCourseIndex: widget.subIndex,
                      subTitle: subCourseName,
                      playListIndex: widget.index,
                    );
                  }
                },
              ),
            ),
            AddSubCourseButton(
                title: 'add playlist',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AddPlaylistTitle(
                        subCourseId: widget.subCourseId,
                        playlistId: 1,
                        courseId: widget.courseId,
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
