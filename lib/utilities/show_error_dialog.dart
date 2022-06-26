import 'package:flutter/material.dart';

Future<void> showalertdialogue(BuildContext context, String error) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("An Error Occured"),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              child: const Text("OK"),
            ),
          ],
        );
      });
}
