import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: AppBar(title: const Text("Register")),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
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
                          print(usercredentials);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "weak-password") {
                            print("Weak Password");
                          } else if (e.code == "email-already-in-use") {
                            print("Email Already In Use");
                          } else if (e.code == "invalid-email") {
                            print("Invalid Email");
                          } else if (e.code == "unknown") {
                            print("Fill Email And Password Fields");
                          } else {
                            print(e.code);
                          }
                        }
                      },
                    ),
                  ],
                );
              default:
                return const Text("Loading...");
            }
          },
        ));
  }
}
