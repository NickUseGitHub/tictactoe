import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String errorMsg;
  const ErrorMsg({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Center(
            child: Text(errorMsg),
          )
        ],
      ),
    );
  }
}
