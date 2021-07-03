import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/pages/reminder_page.dart';
import 'package:simple_reminder/utils/helpers.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final Key key;
  const ReminderCard(this.reminder, {required this.key});

  @override
  Widget build(BuildContext context) {
    var mqWidth = MediaQuery.of(context).size.width;
    return Dismissible(
      key: key,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(4.0),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.0),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mqWidth * 0.60,
                        child: Text(
                          reminder.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      reminder.dateTime != null
                          ? Text(
                              getFormattedDate(reminder.dateTime),
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  //add a little space between titile and desc.
                  reminder.description != null
                      ? SizedBox(height: 4.0)
                      : SizedBox.shrink(),
                  reminder.description != null
                      ? Text(
                          reminder.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            onTap: () => toPage(
                context,
                ReminderPage(
                  isEdit: true,
                  reminder: reminder,
                )),
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Icon(
              EvaIcons.trash,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
      onDismissed: (_) {
        ReminderBox().deleteReminder(reminder.key);
        snackBar(context, 'Reminder deleted');
      },
    );
  }
}
