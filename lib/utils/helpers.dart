import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void toPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

getFormattedDate(DateTime? date) {
  if (date != null)
    return DateFormat('d MMM, hh:mm aa').format(date);
  else
    return '';
}

void snackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
