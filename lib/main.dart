import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/pages/home_page.dart';
import 'package:simple_reminder/utils/color_scheme.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: lightColorScheme.background,
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: darkColorScheme.background,
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
