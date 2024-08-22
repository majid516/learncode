import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/modules/admin_sub_tutorial_detail_pade.dart';

class PalylistTile extends StatelessWidget {
  final String playListTitle;
  final int subIndex;
  final int courseIndex;
  final int playlistIndex;
  const PalylistTile({super.key, required this.playListTitle, required this.subIndex, required this.courseIndex, required this.playlistIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            'clicked clicked clicked clicked clicked clicked clicked  clicked clicked');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AdminSubTutorialDetailPage(
              playListName: playListTitle,
              playlistIndex:playlistIndex ,
               courseindex: courseIndex,
               subCourseindex: subIndex,
                video: 'asset/video/3195394-uhd_3840_2160_25fps.mp4',
                tutorialTitle: 'tutorialTitle')));
      },
      child: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
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
          
            child: Padding(
              padding: const EdgeInsets.only(top: 11, left: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.slideshow,
                  color: themeTextColor,
                  size: 45,
                ),
                title: Text(playListTitle),
              ),
            ),
          ),
        ),
      
    );
  }
}
