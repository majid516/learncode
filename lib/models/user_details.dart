import 'package:hive_flutter/hive_flutter.dart';
part 'user_details.g.dart';

@HiveType(typeId: 10)
class UserDetails {
  @HiveField(0)
  final String userProfile;
  @HiveField(1)
  final String userName;

  UserDetails({required this.userProfile,required this.userName});
}
