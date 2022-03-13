import 'package:flutter/material.dart';

import '../../brand_colors.dart';

class SubmitButton extends StatelessWidget {
  final String text;

  final Color color;

  final VoidCallback onPress;

  SubmitButton({
    required this.onPress,
    required this.text,
    this.color = BrandColors.colorPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size.fromHeight(50),
      ),
    );
  }
}
