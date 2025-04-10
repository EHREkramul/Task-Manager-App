import 'package:flutter/material.dart';

class CenteredCircularProgressBar extends StatelessWidget {
  const CenteredCircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
