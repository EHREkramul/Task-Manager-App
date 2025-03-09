import 'package:flutter/material.dart';

class BottomTexts extends StatelessWidget {
  const BottomTexts({
    super.key,
    required this.directionText,
    required this.buttonText,
    required this.onClick,
  });

  final String directionText;
  final String buttonText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(directionText, style: TextStyle(fontWeight: FontWeight.bold)),
        TextButton(onPressed: onClick, child: Text(buttonText)),
      ],
    );
  }
}
