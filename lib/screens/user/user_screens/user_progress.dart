import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/user_progress_db.dart';
import 'package:learncode/models/course.dart';
import 'package:learncode/modules/admin_course_details_main_page.dart';

class UserProgressPage extends StatefulWidget {
   UserProgressPage({super.key});

  @override
  State<UserProgressPage> createState() => _UserProgressPageState();
}

class _UserProgressPageState extends State<UserProgressPage> {
  ValueNotifier<List<Course>> userProgressNotifier = ValueNotifier([]); 
@override
  void initState() {
    fechPlaylist();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // getAllprogress();
   printAllProgress();
  //getAllProgressBar();
    print('playlist count  = = ${AdminTutorialMainPageDetails.playlistCount}');
   // int point = AdminTutorialMainPageDetails.playlistCount;
   //     print('point count  = = ${point}');
    return Scaffold(
        appBar: AppBar(
          title: Text('progress'),
        ),
        backgroundColor: const Color.fromARGB(255, 220, 255, 234),
        body: ValueListenableBuilder(
          valueListenable: progressNotifier,
          builder: (context, progressValue, child) => ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: userProgressNotifier.value.length,
            itemBuilder: (ctx, index) {
              final progressData = progressValue[index];
              return Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: InkWell(
                  child: Container(
                    width: ScreenSize.widthMed,
                    height: ScreenSize.widthMed * 0.3,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(children: [
                            Row(
                              children: [
                                Container(
                                    width: ScreenSize.widthMed * 0.3,
                                    height: ScreenSize.widthMed * 0.2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                            File(userProgressNotifier.value[index].courseThumbnailPath),
                                          ),
                                          fit: BoxFit.fill),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color:
                                                Colors.black.withOpacity(0.5))
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      userProgressNotifier.value[index].courseTitle,
                                      style: accountPagetextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: ScreenSize.widthMed * 0.42,
                                      child: LinearProgressIndicator(
                                        value:2/ progressData.totalPoint,
                                       borderRadius: BorderRadius.circular(15),
                                        backgroundColor: Colors.grey[300],
                                        color: themeTextColor,
                                      ),
                                    ),
                                    
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Text('${progressData.totalPoint}')
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void fechPlaylist(){
    for (var progress in progressNotifier.value) {
    var value =  courseNotifier.value.firstWhere((value)=> value.id == progress.courseId);
      userProgressNotifier.value.add(value);
    }
    
}
}
