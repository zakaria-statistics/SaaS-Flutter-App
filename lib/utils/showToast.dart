import 'package:flutter/material.dart';
import '../features/user_auth/presentation/widgets/showToast.dart';

void showCustomToast(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width * 0.2,
      right: MediaQuery.of(context).size.width * 0.2,
      child: CustomToast(
        message: message,
        backgroundColor: Colors.red,  // Customize as needed
        textColor: Colors.white,      // Customize as needed
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
