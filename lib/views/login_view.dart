import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynotes/views/register_view.dart';

import '../firebase_options.dart';

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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Login",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          SizedBox(
              width: 350,
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
              width: 350,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text(
                    "enter your password",
                    style: TextStyle(color: Color.fromARGB(255, 201, 199, 199)),
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
            width: 350,
            height: 50,
            child: OutlinedButton(
              onPressed: () async {
                final String email = _email.text;
                final String password = _password.text;
                try {
                  final userCredentials =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  //print(userCredentials);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/Notes/",
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    print("User Not Found");
                  } else if (e.code == "wrong-password") {
                    print("Wrong Password");
                  } else {
                    print(e.code);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 244, 67, 126)),
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
                    .pushNamedAndRemoveUntil("/register/", (route) => false);
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
                width: 125,
                margin: const EdgeInsets.only(right: 20, left: 70),
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
    );
  }
}
