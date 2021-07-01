import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class Reminder extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final DateTime? dateTime;

  @HiveField(3)
  final bool isDone;

  Reminder({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });
}
