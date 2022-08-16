import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const MyCard({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: child,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
