import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';

//import 'package:mynotes/enums/menu_action.dart';
class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuItems>(onSelected: (value) async {
            switch (value) {
              case MenuItems.logout:
                final bool status = await showAlertDialogue(context);
                if (status) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                }
                break;
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuItems>(
                  value: MenuItems.logout, child: Text("Logout"))
            ];
          })
        ],
      ),
    );
  }
}

Future<bool> showAlertDialogue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to log out ?"),
          actions: [
            TextButton(
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Logout"))
          ],
        );
      }).then((value) => value ?? false);
}
