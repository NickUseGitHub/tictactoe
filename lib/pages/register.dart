import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void onFormLoginSubmit(String username, String password) {
    print("================Register[onFormLoginSubmit]================");
    print('text field: ${username}');
    print('-----');
    print('text field: ${password}');
    print("=================================");
  }

  void onTextBtnClick(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
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
}
