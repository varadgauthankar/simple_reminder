import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_reminder/controllers/hive_controller.dart';
import 'package:simple_reminder/models/reminder_model.dart';
import 'package:simple_reminder/providers/reminder_provider.dart';
import 'package:simple_reminder/services/notification_service.dart';
import 'package:simple_reminder/utils/date_time_picker.dart';
import 'package:simple_reminder/utils/helpers.dart';
import 'package:simple_reminder/widgets/confirm_delete.dart';
import 'package:simple_reminder/widgets/date_time_button.dart';
import 'package:simple_reminder/widgets/text_form_field.dart';

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

  bool isDone = false;

  @override
  void initState() {
    notificationService.init();

    if (widget.isEdit) {
      titleController.text = widget.reminder!.title;
      descriptionController.text = widget.reminder?.description ?? '';

      // title = widget.reminder!.title;
      // description = widget.reminder?.description ?? null;
      // dateTime = widget.reminder?.dateTime ?? null;
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
    return Consumer<ReminderProvider>(
      builder: (context, value, child) {
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
          body: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                MyTextFromField(
                  labelText: 'Title',
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  onChanged: (str) => value.setTitle(str),
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Please enter the title';
                    else
                      return null;
                  },
                ),
                SizedBox(height: 12.0),

                MyTextFromField(
                  labelText: "Description",
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (str) => value.setDescription(str),
                  validator: null,
                  maxLines: null,
                ),
                SizedBox(height: 10.0),

                //button to select date and time
                DateTimeButton(
                  text: value.dateTime == null
                      ? 'Add Date & Time'
                      : getFormattedDate(value.dateTime),
                  onPressed: () async {
                    DateTime? pickedDateTime = await pickDateTime(context);
                    value.setDateTime(pickedDateTime);
                  },
                ),
              ],
            ),
          ),

          // floating button
          floatingActionButton: FloatingActionButton(
            heroTag: 'fab',
            child: Icon(EvaIcons.checkmark),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                value.handleSavingReminder(
                  isEdit: widget.isEdit,
                  key: widget.reminder?.key,
                );

                if (value.dateTime != null) {
                  snackBar(context,
                      widget.isEdit ? 'Reminder updated' : 'Reminder set');
                }
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }
}
