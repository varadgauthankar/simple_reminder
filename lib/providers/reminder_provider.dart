import 'package:flutter/material.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:simple_reminder/enums/reminder_repeat.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/services/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  String? _title;
  String? get title => _title;

  String? _description;
  String? get description => _description;

  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;

  ReminderRepeat _reminderRepeat = ReminderRepeat.never;
  ReminderRepeat get reminderRepeat => _reminderRepeat;

  NotificationService _notificationService = NotificationService();
  ReminderBox _reminderBox = ReminderBox();

  void setTitle(String? title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String? description) {
    _description = description;
    notifyListeners();
  }

  void setDateTime(DateTime? dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  void setReminderRepeat(ReminderRepeat reminderRepeat) {
    _reminderRepeat = reminderRepeat;
    notifyListeners();
  }

  void handleSavingReminder({bool isEdit = false, required dynamic key}) {
    Reminder reminder = Reminder(
      title: _title!,
      description: _description,
      dateTime: _dateTime,
      isDone: false,
    );

    // creating reminder
    if (!isEdit) {
      _reminderBox.insertReminder(reminder);
      if (_dateTime != null) {
        _notificationService.scheduleNotification(reminder);
      }
    }

    // updating reminder
    if (isEdit) {
      _reminderBox.updateReminder(key, reminder);
      if (_dateTime != null) {
        _notificationService.scheduleNotification(reminder);
      }
    }
  }
}
