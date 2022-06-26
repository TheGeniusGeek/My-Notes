import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register View"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "My Notes Application",
          ),
          const SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 370,
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "enter your mail",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.clear)),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: SizedBox(
              width: 370,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "enter your password",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.clear)),
              ),
            ),
          ),
          TextButton.icon(
            label: const Text("Register"),
            icon: const Icon(Icons.app_registration_rounded),
            onPressed: () async {
              final String email = _email.text;
              final String password = _password.text;
              try {
                final usercredentials = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                devtools.log(usercredentials.toString());
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(emailVerificationRoute);
              } on FirebaseAuthException catch (e) {
                if (e.code == "weak-password") {
                  devtools.log("Weak Password");
                  showalertdialogue(context, "Weak Password");
                } else if (e.code == "email-already-in-use") {
                  devtools.log("Email Already In Use");
                  showalertdialogue(context, "Email Already In Use");
                } else if (e.code == "invalid-email") {
                  devtools.log("Invalid Email");
                  showalertdialogue(context, "Invalid Email");
                } else if (e.code == "unknown") {
                  devtools.log("Fill Email And Password Fields");
                  showalertdialogue(context, "Fill Email And Password Fields");
                } else {
                  devtools.log(e.code);
                  showalertdialogue(context, "ERROR: ${e.code}");
                }
              } catch (e) {
                showalertdialogue(context, "ERROR: $e");
              }
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Already Registered ? Login Here")),
        ],
      ),
    );
  }
}
