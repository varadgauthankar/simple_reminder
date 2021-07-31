import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/empty.png',
            height: 150,
          ),
          SizedBox(height: 12.0),
          Text(
            'No reminders yet!',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
