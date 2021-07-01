import 'package:flutter/material.dart';

Future<DateTime> pickDateTime(BuildContext context) async {
  DateTime? pickedDate = await pickDate(context);
  TimeOfDay? pickedTime = await pickTime(context);

  return DateTime(
    pickedDate!.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime!.hour,
    pickedTime.minute,
  );
}

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
  );
  if (pickedDate != null)
    return pickedDate;
  else
    return DateTime.now();
}

Future<TimeOfDay?> pickTime(BuildContext context) async {
  TimeOfDay? pickedTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());

  if (pickedTime != null)
    return pickedTime;
  else
    return TimeOfDay.now();
}
