import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/pages/reminder_page.dart';
import 'package:simple_reminder/utils/helpers.dart';
import 'package:simple_reminder/widgets/empty_page.dart';
import 'package:simple_reminder/widgets/reaminder_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReminderBox reminderBox = ReminderBox();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: reminderBox.box.listenable(),
              builder: (context, Box<Reminder> reminders, widget) {
                List<Reminder> remindersList = reminders.values.toList();
                if (remindersList.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: remindersList.length,
                    itemBuilder: (context, index) {
                      var reminder = remindersList[index];

                      return ReminderCard(reminder);
                    },
                  );
                } else {
                  return EmptyPage();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(EvaIcons.plusOutline),
        onPressed: () => toPage(
            context,
            ReminderPage(
              isEdit: false,
            )),
      ),
    );
  }
}
