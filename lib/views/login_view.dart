import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("lib/images/login.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              "Login",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 325,
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "enter your mail",
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 201, 199, 199)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                )),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 325,
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text(
                      "enter your password",
                      style:
                          TextStyle(color: Color.fromARGB(255, 201, 199, 199)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 325,
              height: 60,
              child: OutlinedButton(
                onPressed: () async {
                  final String email = _email.text;
                  final String password = _password.text;
                  try {
                    final userCredentials = await AuthService.firebase()
                        .logIn(email: email, password: password);
                    final user = AuthService.firebase().currentUser;
                    final verified = user?.isEmailVerified ?? false;
                    if (verified) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (route) => false,
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        emailVerificationRoute,
                        (route) => false,
                      );
                    }

                    //print(userCredentials);

                  } on UserNotFoundAuthException {
                    await showalertdialogue(
                      context,
                      "User Not Found",
                    );
                  } on WrongPasswordAuthException {
                    await showalertdialogue(
                      context,
                      "Wrong Password",
                    );
                  } on GenericAuthException {
                    await showalertdialogue(
                      context,
                      "Authentifation error!!",
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 58, 156, 242)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text(
                  "Not Register Yet ? Register Here",
                  style: TextStyle(
                    color: Colors.pink,
                  ),
                )),
            const SizedBox(height: 10),
            const Text("OR"),
            const SizedBox(height: 20),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 125,
                  margin: const EdgeInsets.only(left: 50),
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.link),
                    label: const Text(
                      "Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.blue)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 130,
                  margin: const EdgeInsets.only(left: 20),
                  child: OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Facebook",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
