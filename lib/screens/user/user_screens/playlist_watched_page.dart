import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/modules/admin_sub_tutorial_detail_pade.dart';
import 'package:learncode/screens/admin/widgets/palylist_tile.dart';

class PlayListPage extends StatefulWidget {
    final int index;
    final int subcourseIndex;
    final int courseIndex;
    final int subIndex;

  const PlayListPage({super.key, required this.index, required this.subcourseIndex, required this.courseIndex, required this.subIndex,});

  @override
  // ignore: library_private_types_in_public_api
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: ScreenSize.widthMed,
                  height: ScreenSize.widthMed * 0.65,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'asset/image/5 Tips To Create Awesome Slideshows.jpeg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 35),
                  child: CustomBackButton(
                    buttonColor: buttonPurple,
                    iconColor: whiteColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: courseNotifier,
                  builder: (ctx, newPlaylist, child) {
                    return ListView.builder(
                        itemBuilder: (ctx, index) {
                          return PalylistTile(playListTitle: 'playListTitle', subIndex: widget.subcourseIndex, courseIndex: widget.courseIndex, playlistIndex: index);
                         // return PalylistTile(playListTitle: newPlaylist[widget.courseIndex].courseDetails!.subCourse![widget.subIndex].tutorialPlayList![index].playListTitle,subIndex: index,courseIndex: widget.courseIndex,playlistIndex: index,);
                        },
                        itemCount: 3,
                       // itemCount: newPlaylist[widget.index].courseDetails!.subCourse![widget.subcourseIndex].tutorialPlayList!.length
                       );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
