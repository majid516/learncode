import 'package:hive_flutter/hive_flutter.dart';
import 'package:learncode/models/user_details.dart';

Future<Box<UserDetails>> openDbUserDetails() async {
  return await Hive.openBox<UserDetails>('user_details');
}

Future<void> addUserDetails(UserDetails values) async {
  final userDatas = await openDbUserDetails();
  userDatas.add(values);
}

Future<UserDetails?> fechingUserDetails() async {
  final userDatas = await openDbUserDetails();
  userDatas.get('user');
}
