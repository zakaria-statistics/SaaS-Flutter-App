import 'package:flutter/material.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/not_found_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/profile_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/setting_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:my_web_app/features/user_auth/presentation/router/route_constants.dart';

import '../pages/about_page.dart';

class CustomRouter {
      static Route<dynamic> generatedRoute(RouteSettings settings) {
            switch (settings.name) {
                  case about:
                        print("about case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => AboutPage());
                  case setting:
                        print("setting case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => const SettingPage());
                  case signUp:
                        print("signUp case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => const SignUpPage());
                  case login:
                        print("login case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => const LoginPage());
                  case profile:
                        print("profile case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => ProfilePage());
                  default:
                        print("default case ${settings.name}");
                        return MaterialPageRoute(builder: (_) => const NotFoundPage());
            }
      }
}
