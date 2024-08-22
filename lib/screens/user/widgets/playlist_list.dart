import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_sub_tutorial_detail_pade.dart';

class PlaylistTab extends StatelessWidget {
  final List<TutorialPlayList> playlists;
final int courseIndex ;
final int subCourseIndex;
final String subTitle;
final int playListIndex;
  const PlaylistTab({super.key, required this.playlists, required this.courseIndex, required this.subCourseIndex, required this.subTitle, required this.playListIndex});

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
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AdminSubTutorialDetailPage(video:'asset/video/3195394-uhd_3840_2160_25fps.mp4', tutorialTitle: subTitle, courseindex: courseIndex, subCourseindex: subCourseIndex, playlistIndex: playListIndex,playListName: playlist.playListTitle,)));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 11, left: 20),
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
