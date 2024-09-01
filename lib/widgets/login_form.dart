import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Future Function(String username, String password, BuildContext context)?
      onSubmit;
  final String btnTitle;

  const LoginForm({super.key, required this.btnTitle, this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late final String btnTitle;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    usernameController.addListener(() => _printLatestValue(usernameController));
    passwordController.addListener(() => _printLatestValue(passwordController));

    btnTitle = widget.btnTitle;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _printLatestValue(TextEditingController controller) {
    print('text field: ${controller.text}');
  }

  Future<void> _onFormSubmit(BuildContext context) async {
    if (widget.onSubmit != null) {
      await widget.onSubmit!(
          usernameController.text, passwordController.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Username
          TextFormField(
            controller: usernameController,
            // The validator receives the text that the user has entered.
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
            // },
          ),
          // Password
          TextFormField(
            controller: passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
            // },
          ),
          ElevatedButton(
            onPressed: () {
              // // Validate returns true if the form is valid, or false otherwise.
              // if (_formKey.currentState!.validate()) {
              //   // If the form is valid, display a snackbar. In the real world,
              //   // you'd often call a server or save the information in a database.
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Processing Data')),
              //   );

              //   _onFormSubmit(context);
              // }
              _onFormSubmit(context);
            },
            child: Text(btnTitle),
          ),
        ],
      ),
    );
  }
}
