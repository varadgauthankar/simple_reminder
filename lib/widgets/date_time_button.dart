import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DateTimeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const DateTimeButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(EvaIcons.clockOutline),
          SizedBox(width: 8.0),
          Flexible(child: Text(text))
        ],
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}
