import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/login_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Future<void> onFormLoginSubmit(String username, String password) async {
    print("================Register[onFormLoginSubmit]================");
    print('text field: ${username}');
    print('-----');
    print('text field: ${password}');
    print("=================================");

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
    } on FirebaseAuthException catch (e) {
      final String errorMsg = e.toString();

      print(errorMsg);
      Fluttertoast.showToast(
          msg: errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void onTextBtnClick(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Flex(
                direction: Axis.vertical,
                children: [
                  Center(
                    child: Text(snapshot.error.toString()),
                  )
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: LoginForm(
                              btnTitle: "Register",
                              onSubmit: onFormLoginSubmit,
                            )),
                        TextButton(
                            onPressed: () => onTextBtnClick(context),
                            child: const Text('Back to Home'))
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
