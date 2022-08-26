import 'package:flutter/material.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/pages/reminder_page.dart';
import 'package:simple_reminder/utils/helpers.dart';
import 'package:simple_reminder/widgets/my_card.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  const ReminderCard(this.reminder);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    reminder.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  //add a little space between title and desc.
                  reminder.description != null
                      ? SizedBox(height: 6.0)
                      : SizedBox.shrink(),

                  // description
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
          ),

          // date of the reminder
          reminder.dateTime != null
              ? _dateTimeChip(context)
              : SizedBox.shrink(),
        ],
      ),
      onTap: () {
        toPage(
          context,
          ReminderPage(isEdit: true, reminder: reminder),
        );
      },
    );
  }

  Widget _dateTimeChip(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: reminder.key,
          child: Material(
            color: Colors.transparent,
            child: Chip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                getFormattedDate(reminder.dateTime),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Chip(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          label: Text(
            'weekly',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
        ),
        SizedBox(width: 8.0),
      ],
    );
  }
}
