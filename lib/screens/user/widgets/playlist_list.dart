import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/modules/user_sub_tutorial_detail_page.dart';

class PlaylistTab extends StatelessWidget {
  const PlaylistTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
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
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (ctx) => const UserSubTutorialDetailPage(
                //           video: 'asset/video/3195394-uhd_3840_2160_25fps.mp4',
                //           tutorialTitle: 'Introdution.',
                //         )));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 11, left: 20),
                child: ListTile(
                  leading: const Icon(
                    Icons.slideshow,
                    color: themeTextColor,
                    size: 45,
                  ),
                  title: Text(''
                  //  course.courseDetails!.subCourse![0].tutorialPlayList![0].playListTitle,
                    //style: accountPagetextStyle,
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
