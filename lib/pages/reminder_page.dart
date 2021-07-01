import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/services/notification_service.dart';
import 'package:simple_reminder/utils/date_time_picker.dart';
import 'package:simple_reminder/utils/helpers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
                onPressed: () async {
                  DateTime pickedDateTime = await pickDateTime(context);
                  setState(() {
                    dateTime = pickedDateTime;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.1)),
              )
            ],
          )
        ],
      ),
      floatingActionButton:
          widget.isEdit ? editExerciseButton() : createExerciseButton(),
    );
  }

  Widget createExerciseButton() {
    return FloatingActionButton(
      heroTag: 'fab',
      child: Icon(EvaIcons.checkmarkOutline),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Reminder reminder = Reminder(
            title: this.title,
            description: this.description,
            dateTime: this.dateTime,
            isDone: this.isDone,
          );

          ReminderBox()..insertReminder(reminder);

          if (dateTime != null)
            notificationService.scheduleNotification(reminder);

          Navigator.pop(context);
        }
      },
    );
  }

  //SpeedDial Floating action button
  SpeedDial editExerciseButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      heroTag: 'fab',
      elevation: 3.0,
      closeManually: false,
      backgroundColor: Colors.pink,
      foregroundColor: Colors.black,
      children: [
        SpeedDialChild(
          child: Icon(EvaIcons.saveOutline),
          backgroundColor: Colors.green,
          label: 'Save',
          onTap: () {
            if (formKey.currentState!.validate()) {
              Reminder reminder = Reminder(
                title: this.title,
                description: this.description,
                dateTime: this.dateTime,
                isDone: this.isDone,
              );

              //cancel the previous notification
              notificationService.cancelNotification(widget.reminder!.key);

              ReminderBox()..updateReminder(widget.reminder!.key, reminder);

              //set new notification
              if (reminder.dateTime != null)
                notificationService.scheduleNotification(reminder);

              Navigator.pop(context);
            }
          },
        ),
        SpeedDialChild(
          child: Icon(EvaIcons.trashOutline),
          backgroundColor: Colors.blue,
          label: 'Delete',
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => DeleteAlertDialog(
                onPressed: () {
                  notificationService.cancelNotification(widget.reminder!.key);
                  ReminderBox().deleteReminder(widget.reminder!.key);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
