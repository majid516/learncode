import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/delete_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_sub_course_title.dart';
import 'package:learncode/screens/user/widgets/playlist_list.dart';

// ignore: must_be_immutable
class UserPlayListPage extends StatefulWidget {
  final int index;
  final int courseIndex;
  final int subIndex;
  final String subCourseName;
  String subImage;
  final int subCourseId;
  final bool isAdmin;
  final String subVideo;
  final int? courseId;

  UserPlayListPage({
    super.key,
    required this.subImage,
    required this.index,
    required this.courseIndex,
    required this.subIndex,
    required this.subCourseName,
    required this.subCourseId,
    this.isAdmin = false,
    required this.subVideo,
    this.courseId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _UserPlayListPageState createState() => _UserPlayListPageState();
}

class _UserPlayListPageState extends State<UserPlayListPage> {
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.65,
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
                      widget.isAdmin == true
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
                                            builder: (ctx) =>
                                                UpdateSubCourseTitle(
                                                  subIndex: widget.subIndex,
                                                  subcourseImage:
                                                      widget.subImage,
                                                  subTitle: subCourseName,
                                                ));
                                      },
                                      child: const Text(
                                        'update',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: themeTextColor),
                                      )),
                                ),
                                PopupMenuItem<void>(
                                  child: TextButton(
                                      onPressed: () {
                                        deleteSubCourse(widget.subCourseId);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'delete',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17),
                                      )),
                                ),
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder<List<TutorialPlayList>>(
                valueListenable: playlistNotifier,
                builder: (ctx, playlists, child) {
                  final filteredPlaylists = playlists
                      .where((playlist) =>
                          playlist.subCourseId == widget.subCourseId)
                      .toList();

                  return PlaylistTab(
                    subVideo: widget.subVideo,
                    isAdmin: widget.isAdmin,
                    playlists: filteredPlaylists,
                    courseIndex: widget.courseIndex,
                    subCourseIndex: widget.subIndex,
                    subTitle: subCourseName,
                    playListIndex: widget.index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
