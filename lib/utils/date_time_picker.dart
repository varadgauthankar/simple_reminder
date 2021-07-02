import 'package:flutter/material.dart';
import 'package:simple_reminder/utils/helpers.dart';

Future<DateTime?> pickDateTime(BuildContext context) async {
  DateTime? pickedDate = await pickDate(context);
  TimeOfDay? pickedTime = await pickTime(context);

  if (pickedTime == null || pickedDate == null) {
    snackBar(context, 'Please enter both date and time');
    return null;
  } else {
    DateTime date = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (date.isAfter(DateTime.now())) {
      return date;
    } else {
      snackBar(context, 'Time cannot be in the past!');
      return null;
    }
  }
}

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );
  // if (pickedDate != null )
  //   return pickedDate;
  // else
  //   return DateTime.now();

  return pickedDate;
}

Future<TimeOfDay?> pickTime(BuildContext context) async {
  TimeOfDay? pickedTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());

  // if (pickedTime != null)
  //   return pickedTime;
  // else
  //   return TimeOfDay.now();

  return pickedTime;
}
