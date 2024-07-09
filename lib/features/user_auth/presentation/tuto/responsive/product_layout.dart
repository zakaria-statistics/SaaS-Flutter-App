import 'package:flutter/material.dart';
import 'package:my_web_app/features/user_auth/presentation/tuto/responsive/responsive_layout.dart';
import 'package:my_web_app/features/user_auth/presentation/tuto/responsive/tablet_view_page.dart';

import 'desktop_view_page.dart';
import 'mobile_view_page.dart';
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products page'),
      ),
      body: Responsive(
        mobile: MobileProductPage(),
        tablet: TabletProductPage(),
        desktop: DesktopProductPage(),
      ),
    );
  }
}