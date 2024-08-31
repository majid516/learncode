import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_sub_tutorial_detail_pade.dart';

class PlaylistTab extends StatelessWidget {
  final List<TutorialPlayList> playlists;
  final int courseIndex;
  final int subCourseIndex;
  final String subTitle;
  final int playListIndex;
  final bool isAdmin;
  final String subVideo;
  const PlaylistTab({
    super.key,
    required this.playlists,
    required this.courseIndex,
    required this.subCourseIndex,
    required this.subTitle,
    required this.playListIndex,
    required this.isAdmin,
    required this.subVideo,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 10, horizontal: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: homeColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(61, 0, 0, 0),
                      blurRadius: 3,
                      offset: Offset(0, 3))
                ]),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AdminSubTutorialDetailPage(
                         playlist: playlist,
                         playlistId: playlist.playlistId,
                         subVideo: playlist.subCourseDetails!.subCourseVideo ,
                         subcourseId: playlist.subCourseId,
                          tutorialTitle: subTitle,
                          courseindex: courseIndex,
                          subCourseindex: subCourseIndex,
                          playlistIndex: playListIndex,
                          playListName: playlist.playListTitle,
                          isAdmin: isAdmin,
                        //  subVideo: subVideo,
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 11, left: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.slideshow,
                    color: themeTextColor,
                    size: 45,
                  ),
                  title: Text(
                    playlist.playListTitle,
                    style: accountPagetextStyle,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
