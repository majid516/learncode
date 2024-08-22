import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_playlist_title.dart';
import 'package:learncode/screens/admin/update_corse.dart/update_sub_course_title.dart';
import 'package:learncode/screens/user/widgets/playlist_list.dart';

class PlayListPage extends StatefulWidget {
  final int index;
  final int courseIndex;
  final int subIndex;
  final String subCourseName;
  String subImage;

   PlayListPage({
    super.key,
    required this.subImage,
    required this.index,
    required this.courseIndex,
    required this.subIndex,
    required this.subCourseName, 
  });

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    fechingPlaylist(); // Ensure this function is correctly defined to populate `playlistNotifier`
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
                      PopupMenuButton<void>(
                        icon:const Icon(
                          Icons.more_vert_outlined,
                          color: whiteColor, 
                          size: 40,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem<void>(
                            child:TextButton(onPressed: (){
                              showDialog(context: context, builder: (ctx)=> UpdateSubCourseTitle(
                                subIndex: widget.subIndex,
                                subcourseImage: widget.subImage,subTitle: subCourseName,));
                            }, child: Text('update')),
                          ),
                          PopupMenuItem<void>(
                            child: TextButton(onPressed: (){}, child: Text('delete')),
                          ),
                        ],
                      ),
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
                      .where(
                          (playlist) => playlist.subCourseName == subCourseName)
                      .toList();

                  return PlaylistTab(
                    playlists: filteredPlaylists,
                    courseIndex: widget.courseIndex,
                    subCourseIndex: widget.subIndex,
                    subTitle: subCourseName,
                    playListIndex: widget.index,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(widget.subCourseName);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => AddPlaylistTitle(
                      subCourseTitle: widget
                          .subCourseName, 
                    ),
                  ),
                );
              },
              child: const Text('Add List'),
            ),
          ],
        ),
      ),
    );
  }
}
