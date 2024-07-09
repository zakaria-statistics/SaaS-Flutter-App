import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;

  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust duration as needed
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Navigate to the next screen after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        FirebaseAuth.instance.signOut();
        GoRouter.of(context).go('/login');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: const Text(
            "Welcome To LOGITECH Store",
            style: TextStyle(
              fontSize: 28,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}