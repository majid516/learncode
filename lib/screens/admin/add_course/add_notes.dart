import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/constants/mediaquery.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';

class AddNotes extends StatefulWidget {
  final String playListName;

  AddNotes({super.key, required this.playListName});

  static Map<String, String> questionNotes = {};

  static TextEditingController questionController = TextEditingController();
  static TextEditingController answerController = TextEditingController();

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  void initState() {
    super.initState();
    // Load any existing notes for this playlist
    _loadExistingNotes();
  }

  Future<void> _loadExistingNotes() async {
    final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
    final existingNotes = noteBox.values.where((note) => note.playListName == widget.playListName).toList();
    if (existingNotes.isNotEmpty) {
      setState(() {
        AddNotes.questionNotes = Map.fromIterables(
          existingNotes.first.questions,
          existingNotes.first.answers,
        );
      });
    }
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
      widget.playListName,
      questions: questions,
      answers: answers,
    );

    final noteBox = await Hive.openBox<QuestionNotes>('QuestionNotes');
    await noteBox.add(note);

    // Update the notifier with the latest data
    final notes = noteBox.values.where((n) => n.playListName == widget.playListName).toList();
    questionNoteNotifier.value = notes;

    setState(() {
      AddNotes.questionNotes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: ScreenSize.widthMed,
        height: ScreenSize.heightMed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(AddNotes.questionController, 'Enter Question'),
            SizedBox(height: ScreenSize.heightMed * 0.02),
            const Text('Add Question Note', style: addTutorialPagestyle),
            SizedBox(height: ScreenSize.heightMed * 0.03),
            _buildTextField(AddNotes.answerController, 'Enter Answer'),
            SizedBox(height: ScreenSize.heightMed * 0.02),
            const Text('Add Answer Note', style: addTutorialPagestyle),
            Expanded(
              child: ListView.builder(
                itemCount: AddNotes.questionNotes.length,
                itemBuilder: (context, index) {
                  String question = AddNotes.questionNotes.keys.elementAt(index);
                  String answer = AddNotes.questionNotes[question]!;
                  return ListTile(
                    title: Text(question),
                    subtitle: Text(answer),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: addNote,
            //   child: const Text('Add Another Note'),
            // ),
            ElevatedButton(
              onPressed: () async {
               addNote();
                await addNotesToDatabase();
                Navigator.of(context).pop();
              },
              child: const Text('Save Notes'),
            ),
          ],
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
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText),
      ),
    );
  }
}
