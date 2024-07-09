import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/image_loader.dart';

class UserProfileInfo extends StatefulWidget {
  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
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
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User ID: ${user.uid}'),
                Text('Email: ${user.email ?? 'Not available'}'),
                Text('Display Name: '),
                Center(
                  child: imageUrl.isEmpty
                      ? CircularProgressIndicator()
                      : Image.network(
                          imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            print("Error loading image: $error");
                            return Text("Error loading image");
                          },
                        ),
                ),
                // Add more user information as needed
              ],
            )
          : Center(
              child: Text('No user signed in.'),
            ),
    );
  }
}
