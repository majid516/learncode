import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/buttons/submit_button.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/report_db.dart';
import 'package:learncode/models/reports.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedCategory;
  final TextEditingController descriptionController = TextEditingController();

  final List<String> reportCategories = [
    'Course Issue',
    'Sub-course Issue',
    'Playlist Issue',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        iconColor: themeTextColor,
                        buttonColor: buttonGrey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    const Text(
                      'Report an Issue',
                      style: tutorialPageTitletextStyle,
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Select Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                hint: const Text('Choose a category'),
                items: reportCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Describe the Issue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Enter details about the issue...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SubmitButton(
                    onPressed: () async {
                      await _submitReport(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitReport(BuildContext context) async {
    if (selectedCategory != null && descriptionController.text.isNotEmpty) {
      final report = Report(
        catogory: selectedCategory!,
        issue: descriptionController.text,
      );
      await addReport(report);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incomplete Form'),
            content:
                const Text('Please complete all fields before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
