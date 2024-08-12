import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
                  width: ScreenSize.widthMed * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadiusDirectional.circular(12),
                    border: Border.all(width: 0.2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(95, 0, 0, 0),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                                SizedBox(height: ScreenSize.heightMed*0.02,),

                const Text(
          'add question note',
          style: addTutorialPagestyle,
        ),
                SizedBox(height: ScreenSize.heightMed*0.03,),
                 Container(
              width: ScreenSize.widthMed * 0.8,
              height: 60,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadiusDirectional.circular(12),
                border: Border.all(width: 0.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(95, 0, 0, 0),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
                            SizedBox(height: ScreenSize.heightMed*0.02,),

            const Text(
          'add answer note',
          style: addTutorialPagestyle,
        ),
      ],
    );
  }
}