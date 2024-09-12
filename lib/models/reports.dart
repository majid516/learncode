
import 'package:hive_flutter/hive_flutter.dart';
part 'reports.g.dart';
@HiveType(typeId: 14)
class Report {
  @HiveField(0)
  final String catogory;
  @HiveField(1)
  final String issue;

  Report({required this.catogory,required this.issue,} );
}
