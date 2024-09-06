import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';

class ProgressCard extends StatefulWidget {
   ProgressCard({super.key, });
  int a = playlistNotifier.value.length;
  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    fechingPlaylist();
    return Padding(
      padding:  EdgeInsetsDirectional.only(top: 20),
      child: Center(
        child: Container(
          width: ScreenSize.widthMed * 0.9,
          height: ScreenSize.heightMed * 0.3,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(141, 123, 123, 123),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.only(top: 40, left: 30),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                       width: ScreenSize.widthMed * 0.25,
                      height: ScreenSize.widthMed * 0.25,
                      child:const  CircularProgressIndicator(
                        strokeWidth: 15,
                        strokeCap: StrokeCap.round,
                        value:0.4,
                        color: themeTextColor,
                        backgroundColor: homeColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Completed',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    const Text('43%',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w800))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                        width: ScreenSize.widthMed * 0.42,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(15),
                           value:1/1,
                          backgroundColor: Colors.grey[300],
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                       Text('3333'),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 5,
                        width: ScreenSize.widthMed * 0.42,
                        child: LinearProgressIndicator(
                          value: 0.5,
                          borderRadius: BorderRadius.circular(15),
                          backgroundColor: Colors.grey[300],
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                       Text('enrolleitle'),
                      // const SizedBox(height: 15),
                      // SizedBox(
                      //   height: 5,
                      //   width: ScreenSize.widthMed * 0.42,
                      //   child: LinearProgressIndicator(
                      //     value: 0.5,
                      //     borderRadius: BorderRadius.circular(15),
                      //     backgroundColor: Colors.grey[300],
                      //     color: Colors.red,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      //Text(enrolledCourseNotifier.value[2].courseThumbnailPath),
                                             SizedBox(height: ScreenSize.heightMed*0.01),
                      TextButton(onPressed: (){
                      }, child:const Text('see more',style: TextStyle(fontWeight: FontWeight.w600,color: themeTextColor),))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
