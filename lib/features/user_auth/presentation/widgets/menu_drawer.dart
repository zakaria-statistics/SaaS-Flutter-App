import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/routing_bloc.dart';
import '../../../../utils/image_loader.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late String imageUrl;
  late String urlPath = "logo.png";
  final ImageLoader imageLoader = ImageLoader();

  @override
  void initState() {
    super.initState();
    imageUrl = '';
    loadImageUrl();
  }

  Future<void> loadImageUrl() async {
    final url = await imageLoader.getImageUrl(urlPath);
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text('Menu', style: TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<RoutingBloc>().add(HomeEvent());
                    updateUrl('/mainPage/home');
                    context.pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: const Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<RoutingBloc>().add(ProductsEvent());
                    updateUrl('/mainPage/products');
                    context.pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text(
                    'About',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<RoutingBloc>().add(AboutEvent());
                    updateUrl('/mainPage/about');
                    context.pop();
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
void updateUrl(String url) {
  window.history.pushState({}, '', url);
}