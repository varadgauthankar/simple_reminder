import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/pages/home_page.dart';
import 'package:simple_reminder/utils/theme_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<Reminder>('reminders');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'simple reminder',
      theme: MyThemeData.light,
      darkTheme: MyThemeData.dark,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
