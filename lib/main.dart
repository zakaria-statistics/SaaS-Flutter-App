import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/features/app/splash_screen/splash_screen.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZZNYh6IHjR1hQsbcJN44C3cYGkiX7tLg",
          appId: "1:895108934473:web:511aa7763d359bf3e94898",
          messagingSenderId: "895108934473",
          projectId: "firstapp-6a3b2"),
    );
  }else{
    await Firebase.initializeApp();
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      home: SplashScreen(
          child: LoginPage(),
      )
    );
  }
}
