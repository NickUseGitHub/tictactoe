import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'register.dart';
import 'board.dart';
import '../widgets/login_form.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> showToast(BuildContext context) async {
    Fluttertoast.showToast(
        msg: "Helll yeah",
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

  void onFormLoginSubmit(String username, String password) {
    print("================Home[onFormLoginSubmit]================");
    print('text field: ${username}');
    print('-----');
    print('text field: ${password}');
    print("=================================");
  }

  @override
  Widget build(BuildContext context) {
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
}
