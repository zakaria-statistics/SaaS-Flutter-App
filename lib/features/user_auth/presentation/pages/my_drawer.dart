import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_web_app/bloc/cart_bloc/cart_bloc.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../bloc/theme_bloc.dart';
import '../../../../classes/language_constants.dart';
import '../../../../global/common/toast.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadUserProfilePicture();
  }

  Future<void> loadUserProfilePicture() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    print('profile');
    print(user?.uid);
    print('profile');

    if (user != null) {
      // Assuming the profile picture URL is stored in the user's document in Firestore
      DocumentSnapshot userProfileSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      print('profile');
      print(userProfileSnapshot.id);
      print('profile');

      // Check if the user document exists and contains the profile picture URL
      if (userProfileSnapshot.exists && userProfileSnapshot.data() != null) {
        String? profilePictureUrl = userProfileSnapshot['photo'];

        if (profilePictureUrl != null) {
          // Update the imageUrl state variable to trigger a rebuild
          setState(() {
            imageUrl = profilePictureUrl;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        // Adjust the radius as needed
                        backgroundColor: Colors.transparent,
                        // Transparent background to make the image circular
                        child: ClipOval(
                          child: imageUrl.isEmpty
                              ? const CircularProgressIndicator(
                            color: Colors.grey,
                          )
                              : Image.network(
                                  imageUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    print("Error loading image: $error");
                                    return const Text("Error loading image");
                                  },
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width:
                                      100, // Ensure the image covers the circular area
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    //context.go('/profile');
                    context.pop();
                    context.read<RoutingBloc>().add(ProfileEvent());
                    updateUrl('/mainPage/profile');
                  },
                ),
                /*ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text(
                    'My Posts',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    //context.go("/profile/posts");
                    context.pop();
                    context.read<RoutingBloc>().add(PostsEvent());
                    updateUrl('/mainPage/profile/posts');
                  },
                ),*/
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return ListTile(
                      leading: const Icon(Icons.color_lens),
                      title: const Text(
                        'Themes',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: () {
                        context.read<ThemeBloc>().add(SwitchThemeEvent());
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(
                    'Setting',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    //context.go("/settings");
                    context.pop();
                    context.read<ProductBloc>().add(AllProductsEvent());
                    context.read<RoutingBloc>().add(SettingsEvent());
                    updateUrl('/mainPage/settings');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    context.read<CartBloc>().add(ResetCart());
                    _signOut();
                  },
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 16),
            child: const Text(
              'Copyright © 2024 | Deutsch',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      context.replace('/login');
      showToast(message: translation(context).homeSignOutSuccessMessage);
    } catch (e) {
      print("Sign out failed: $e");
    }
  }
}

void updateUrl(String url) {
  window.history.pushState({}, '', url);
}
