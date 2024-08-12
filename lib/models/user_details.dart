import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_details.g.dart';

@HiveType(typeId: 1)
class UserDetails {
  @HiveField(0)
  final ImageProvider<Object> userProfile;
  @HiveField(1)
  final String userName;

  UserDetails({required this.userProfile, required this.userName});
}
