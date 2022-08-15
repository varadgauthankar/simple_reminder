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
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(4.0),
        child: Material(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12.0),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: reminder.dateTime != null
                            ? mqWidth * 0.50
                            : mqWidth * 0.85,
                        child: Text(
                          reminder.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),

                      // date of the reminder
                      reminder.dateTime != null
                          ? Chip(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              label: Text(
                                getFormattedDate(reminder.dateTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
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
                          style: TextStyle(fontSize: 16, height: 1.2),
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
