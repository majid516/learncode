import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/admin_details.dart';

Future<void> addAdminDetails(AdminDetails value)async{
 final adminBox = await Hive.openBox<AdminDetails>('AdminDetails');
  await adminBox.add(value);
}