import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';

class AddNotes extends StatefulWidget {
  final int playListId;

  const AddNotes({super.key, required this.playListId});

  static Map<String, String> questionNotes = {};

  static TextEditingController questionController = TextEditingController();
  static TextEditingController answerController = TextEditingController();

  @override
  State<AddNotes> createState() => _AddNotesState();
}


class _AddNotesState extends State<AddNotes> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void addNote() {
    final question = AddNotes.questionController.text;
    final answer = AddNotes.answerController.text;

    if (question.isNotEmpty && answer.isNotEmpty) {
      setState(() {
        AddNotes.questionNotes[question] = answer;
      });

      AddNotes.questionController.clear();
      AddNotes.answerController.clear();
    }
  }

  Future<void> addNotesToDatabase() async {
    final questions = AddNotes.questionNotes.keys.toList();
    final answers = AddNotes.questionNotes.values.toList();

    final note = QuestionNotes(
      playlistId: widget.playListId,
      questions: questions,
      answers: answers,
    );
    final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
    await noteBox.add(note);
 
    final notes =
        noteBox.values.where((n) => n.playlistId == widget.playListId).toList();
    questionNoteNotifier.value = notes;

    setState(() {
      AddNotes.questionNotes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: ScreenSize.widthMed,
          height: ScreenSize.heightMed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(AddNotes.questionController, 'Enter Question'),
              SizedBox(height: ScreenSize.heightMed * 0.02),
              const Text('Add Question Note', style: addTutorialPagestyle),
              SizedBox(height: ScreenSize.heightMed * 0.03),
              _buildTextField(AddNotes.answerController, 'Enter Answer'),
              SizedBox(height: ScreenSize.heightMed * 0.02),
              const Text('Add Answer Note', style: addTutorialPagestyle),
              const SizedBox(
                height: 30,
              ),
              SubmitButton(onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  addNote();
                  await addNotesToDatabase();
                  Navigator.of(context).pop();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
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
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
}
