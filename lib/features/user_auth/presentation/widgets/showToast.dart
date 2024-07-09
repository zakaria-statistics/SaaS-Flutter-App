import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const CustomToast({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16.0),
      ),
    );
  }
}
