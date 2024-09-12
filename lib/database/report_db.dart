
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/reports.dart';
ValueNotifier<List<Report>> reportNotifier = ValueNotifier([]);


Future<void> addReport(Report value)async{
 final reportBox = await Hive.openBox<Report>('reports');
  await reportBox.add(value);
   reportNotifier.value = reportBox.values.toList();
  reportNotifier.notifyListeners();
}
Future<void> printAllReports() async {
 final reportBox = await Hive.openBox<Report>('reports');
  reportNotifier.value = reportBox.values.toList();
  reportNotifier.notifyListeners();
}