import 'package:hive_flutter/hive_flutter.dart';
part 'admin_details.g.dart';

@HiveType(typeId: 12)
class AdminDetails {
  @HiveField(0)
  final String? adminName;
  @HiveField(1)
  final String? adminProfile;
  AdminDetails(this.adminName, this.adminProfile);
}
