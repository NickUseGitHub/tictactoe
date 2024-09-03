import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../ctx/user_data.dart';
import '../widgets/error.dart';

import 'register.dart';
import 'board.dart';
import '../widgets/login_form.dart';

class Home extends StatelessWidget {
  static const String id = 'home_screen';

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Home({super.key});

  Future<void> showToast(BuildContext context) async {
    Fluttertoast.showToast(
        msg: "Hello world V.5",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    print('ready to play in 1...');
    await Future.delayed(const Duration(seconds: 1));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Board()),
    );
  }

  void onTextBtnSignUpClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  Future<UserCredential?> onFormLoginSubmit(
      String username, String password, BuildContext context) async {
    Navigator.pushReplacementNamed(
      context,
      Board.id,
    );

    // print("================Home[onFormLoginSubmit]================");
    // print('text field: ${username}');
    // print('-----');
    // print('text field: ${password}');
    // print("=================================");

    // try {
    //   UserCredential user = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: username, password: password);

    //   print("************** Success **************");

    //   if (user.user != null) {
    //     print("> user.user");
    //     print(user.user);
    //     print("---------------------");

    //     Provider.of<UserData>(context, listen: false).setUserData(user);

    //     Navigator.pushReplacementNamed(
    //       context,
    //       Board.id,
    //     );
    //   }
    // } on FirebaseAuthException catch (e) {
    //   final String errorMsg = e.toString();

    //   print(errorMsg);
    //   Fluttertoast.showToast(
    //       msg: errorMsg,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);

    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorMsg(errorMsg: snapshot.error.toString());
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
                              btnTitle: "Login",
                              onSubmit: onFormLoginSubmit,
                            )),
                        TextButton(
                            onPressed: () => onTextBtnSignUpClick(context),
                            child: const Text('Sign Up'))
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        });
  }
}
