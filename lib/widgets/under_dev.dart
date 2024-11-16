import 'package:flutter/material.dart';

class UnderDevelopmentDialog extends StatelessWidget {
  final String message;

  const UnderDevelopmentDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.orange,
          ),
          SizedBox(width: 10),
          Text('Under Development'),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

void showUnderDevelopmentDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UnderDevelopmentDialog(message: message);
    },
  );
}
