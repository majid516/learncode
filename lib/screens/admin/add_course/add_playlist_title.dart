import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/models/course.dart';

class AddPlaylistTitle extends StatefulWidget {
  static List<TutorialPlayList> playlistList = [];
   AddPlaylistTitle({super.key,});

  @override
  State<AddPlaylistTitle> createState() => _AddPlaylistTitleState();
}

class _AddPlaylistTitleState extends State<AddPlaylistTitle> {
  final playListTitleController = TextEditingController();
@override
  void dispose() {
    AddPlaylistTitle.playlistList.add(TutorialPlayList(playListTitle: playListTitleController.text));
    print('\nplatlist List is disposed\n');
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: ScreenSize.widthMed * 0.75,
            height: 60,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadiusDirectional.circular(12),
              border: Border.all(width: 0.2),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(95, 0, 0, 0),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: TextFormField(
              controller: playListTitleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(
            height: ScreenSize.heightMed * 0.03,
          ),
          const Text(
            'add sub course title',
            style: addTutorialPagestyle,
          ),
      ],
    );
  }
}