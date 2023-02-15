import 'package:flutter/material.dart';

class BoxPlay extends StatelessWidget {
  final String? display;
  final Function? onBoxPlayClick;

  const BoxPlay({super.key, this.display, this.onBoxPlayClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onBoxPlayClick == null) {
          return;
        }

        onBoxPlayClick!();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[100],
        child: display != null && display!.isNotEmpty
            ? Image(
                fit: BoxFit.contain, image: AssetImage('assets/$display.png'))
            : null,
      ),
    );
  }
}
