import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;

  const SubmitButtonWidget({super.key, 
    required this.onPressed,
    required this.text,
    this.width = 50,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
