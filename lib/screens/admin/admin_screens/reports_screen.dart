import 'package:flutter/material.dart';
import 'package:learncode/buttons/backbutton.dart';
import 'package:learncode/constants/constants.dart';
import 'package:learncode/database/report_db.dart';
import 'package:learncode/models/reports.dart';

class AdminReortPage extends StatelessWidget {
  const AdminReortPage({super.key});

  @override
  Widget build(BuildContext context) {
    printAllReports();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
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
                      'Reports',
                      style: tutorialPageTitletextStyle,
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: reportNotifier,
                  builder: (context, List<Report> reports, widget) {
                    if (reports.isEmpty) {
                      return const Center(child: Text('No reports available.'));
                    } else {
                      return ListView.separated(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];
                          return ListTile(
                            title: Text(
                              report.catogory,
                              style: addTutorialPagestyle,
                            ),
                            subtitle: Text(
                              report.issue,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
