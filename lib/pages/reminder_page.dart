import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/services/notification_service.dart';
import 'package:simple_reminder/utils/date_time_picker.dart';
import 'package:simple_reminder/utils/helpers.dart';
import 'package:simple_reminder/widgets/confirm_delete.dart';

class ReminderPage extends StatefulWidget {
  final bool isEdit;
  final Reminder? reminder;
  const ReminderPage({
    Key? key,
    this.isEdit = false,
    this.reminder,
  }) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NotificationService notificationService = NotificationService();
  ReminderBox reminderBox = ReminderBox();

  late String title;
  String? description;
  DateTime? dateTime;
  bool isDone = false;

  @override
  void initState() {
    notificationService.init();

    if (widget.isEdit) {
      titleController.text = widget.reminder!.title;
      descriptionController.text = widget.reminder?.description ?? '';

      title = widget.reminder!.title;
      description = widget.reminder?.description ?? null;
      dateTime = widget.reminder?.dateTime ?? null;
      isDone = widget.reminder!.isDone;
    }
    super.initState();
  }

  void deleteReminder() {
    notificationService.cancelNotification(widget.reminder!.key);

    reminderBox.deleteReminder(widget.reminder!.key);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Reminder' : 'Create Reminder'),
        actions: [
          // delete Reminder icon
          widget.isEdit
              ? IconButton(
                  icon: Icon(EvaIcons.trashOutline),
                  tooltip: 'Delete reminder',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteAlertDialog(
                        onPressed: deleteReminder,
                      ),
                    );
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                        hintText: "Title",
                      ),
                      onChanged: (value) => this.title = value,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please enter the title';
                        else
                          return null;
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Description",
                        hintText: "Description",
                      ),
                      maxLines: null,
                      onChanged: (value) => this.description = value,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(EvaIcons.clockOutline),
                    SizedBox(width: 8.0),
                    Text(dateTime == null
                        ? 'Add Date & Time'
                        : getFormattedDate(dateTime))
                  ],
                ),
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                ),
                onPressed: () async {
                  DateTime? pickedDateTime = await pickDateTime(context);
                  setState(() {
                    dateTime = pickedDateTime;
                  });
                },
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(EvaIcons.checkmark),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Reminder reminder = Reminder(
              title: this.title,
              description: this.description,
              dateTime: this.dateTime,
              isDone: this.isDone,
            );

            if (widget.isEdit) {
              notificationService.updateNotification(reminder);

              reminderBox.updateReminder(widget.reminder!.key, reminder);

              //set new notification
              if (reminder.dateTime != null) {
                notificationService.scheduleNotification(reminder);

                snackBar(context,
                    'Notification set at ${getFormattedDate(dateTime)}');
              }

              Navigator.pop(context);
            } else {
              reminderBox.insertReminder(reminder);

              if (dateTime != null) {
                notificationService.scheduleNotification(reminder);
                snackBar(context,
                    'Notification set at ${getFormattedDate(dateTime)}');
              }

              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
