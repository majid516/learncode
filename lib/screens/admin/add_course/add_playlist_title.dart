import 'package:flutter/material.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/screens/admin/add_course/add_sub_course_details.dart';

class AddPlaylistTitle extends StatefulWidget {
  final String? subCourseTitle;

  static List<TutorialPlayList> playlistList = [];

  AddPlaylistTitle({
    super.key,
    this.subCourseTitle,
  });

  @override
  State<AddPlaylistTitle> createState() => _AddPlaylistTitleState();
}

class _AddPlaylistTitleState extends State<AddPlaylistTitle> {
  final playListTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: ScreenSize.widthMed * 0.9,
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
            'Add Sub Course Title',
            style: addTutorialPagestyle,
          ),
          SizedBox(
            height: 30,
          ),
          SubmitButton(onPressed: () async {
            final title = playListTitleController.text.trim();
            if (title.isNotEmpty && widget.subCourseTitle != null) {
              final data = TutorialPlayList(
                playListTitle: title,
                subCourseName: widget.subCourseTitle??'',
              );
              print(widget.subCourseTitle);
              await addPlayList(data);
              Navigator.of(context).pop();

            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SubCourseTitle is missing')),
              );
            }
          })
        ],
      ),
    );
  }
}
