import 'package:flutter/material.dart';
import 'package:my_web_app/features/app/splash_screen/splash_screen.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/about_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/products_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/profile_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/store_page.dart';
import 'package:go_router/go_router.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page1.dart';
import '../pages/invoice_page.dart';
import '../pages/item_page.dart';
import '../pages/main_page.dart';
import '../pages/setting_page.dart';

class MyRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Define your routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signUp',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/mainPage',
        builder: (context, state) => MainScreen(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomePage1(),
          ),
          GoRoute(
            path: 'products',
            builder: (context, state) => const UsersProductsPage(),
            routes: [
              GoRoute(
                path: 'item',
                builder: (context, state) => ItemPage(id: state.pathParameters['item']!),
              )
            ]
          ),
          GoRoute(
            path: 'store',
            builder: (context, state) => StorePage(id: state.pathParameters['user']!),

          ),
          GoRoute(
            path: 'about',
            builder: (context, state) => AboutPage(),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => ProfilePage(),
          ),
          GoRoute(
            path: 'cart',
            builder: (context, state) => CartScreen(),
          ),
          GoRoute( // Add the new route for checkout
            path: 'checkout',
            builder: (context, state) => CheckoutScreen(),
          ),
          GoRoute( // Add the new route for checkout
            path: 'invoice',
            builder: (context, state) => InvoiceSummaryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(), // Default route
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text("Page not found"),
      ),
    ),
  );
}
