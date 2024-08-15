import 'package:flutter/material.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});
 static List<String> questionList = [];
 static List<String> answerList = [];


  static final questionController = TextEditingController();
  static final answerController = TextEditingController();

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  void dispose() {
     AddNotes.questionList.add(AddNotes.questionController.text);
     AddNotes.answerList.add(AddNotes.answerController.text);

    // TODO: implement dispose
    super.dispose();
  }
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
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller:AddNotes.questionController,
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
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextFormField(
                controller: AddNotes.answerController,
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