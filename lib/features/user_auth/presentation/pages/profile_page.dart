/*import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/bloc/routing_bloc.dart';
import 'package:my_web_app/classes/language_constants.dart';
import 'package:my_web_app/features/user_auth/presentation/widgets/text_box.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../utils/image_loader.dart';
import '../../../../utils/path_util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  late String field = '';

  //all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit  $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    //update in firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  late String urlPath = '';
  final String path = 'profile';

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadImageUrl() async {
    try {
      final url = await ImageLoader().openPicker(path);
      setState(() {
        urlPath = url;
      });
    } catch (error) {
      print("Error loading image: $error");
      // Handle error gracefully, such as displaying an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(60.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<DocumentSnapshot>(
                    stream: usersCollection.doc(currentUser.uid).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            height: screenHeight * 0.55,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                )
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.01),
                              //border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: screenHeight * 0.15,
                                  width: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Stack(
                                      children: [
                                        userData['photo'] != ''
                                            ? Center(
                                                child: Container(
                                                  height: screenWidth * 0.05,
                                                  width: screenWidth * 0.05,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      // Fit the image to cover the entire circle
                                                      image: NetworkImage(
                                                          userData['photo'] ??
                                                              ''),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Container(
                                                  height: screenWidth * 0.05,
                                                  width: screenWidth * 0.05,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                    ),
                                                  child: Center(
                                                    child: Container(
                                                      height: screenWidth * 0.02,
                                                      width: screenWidth * 0.02,
                                                      child: CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        Positioned(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_a_photo,
                                              color: Colors.blueGrey,
                                            ),
                                            onPressed: () async {
                                              await loadImageUrl();

                                              if (urlPath.isNotEmpty) {
                                                usersCollection
                                                    .doc(currentUser.uid)
                                                    .update({'photo': urlPath});
                                              }
                                            },
                                          ),
                                          top: screenHeight * 0.072,
                                          left: screenWidth * 0.085,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.23,
                                        height: screenHeight * 0.07,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Username:',
                                                    style: TextStyle(
                                                        fontSize: screenWidth *
                                                            0.012),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    userData['username'] ?? '',
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.01,
                                                        color: Colors
                                                            .grey.shade600),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.23,
                                        height: screenHeight * 0.07,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Email:',
                                                    style: TextStyle(
                                                        fontSize: screenWidth *
                                                            0.012),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    userData['email'] ?? '',
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.01,
                                                        color: Colors
                                                            .grey.shade600),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.1,
                                        height: screenHeight * 0.04,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade500,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )),
                                        child: TextButton(
                                          onPressed: () {
                                            context.read<RoutingBloc>().add(StoreEvent(userId: currentUser.uid));
                                            context.read<ProductBloc>().add(UserProductsEvent(userId: currentUser.uid));
                                            updateUrl('/mainPage/${currentUser.uid}/store');
                                          },
                                          child: Text('Go to Store'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        print('Error => ${snapshot.error}');
                      }
                      return Container();
                    }),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    height: screenHeight * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('Account Status:'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Suspend',
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Disactivate',
                                          style: TextStyle(
                                              color: Colors.blue.shade900),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Activated',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Reviews'),
                                Row(
                                  children: [
                                    Text(
                                      '4.5k',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text('Insights'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Seen by'),
                                    Row(
                                      children: [
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Messages'),
                                    Row(
                                      children: [
                                        Text(
                                          '12',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget profileBody() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .snapshots(),
      builder: (context, snapshot) {
        //get user data
        if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              //profile pic
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100, // adjust as needed
                        height: 100, // adjust as needed
                        child: userData['photo'].isEmpty
                            ? CircularProgressIndicator()
                            : Image.network(
                                userData['photo'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print("Error loading image: $error");
                                  return const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    // placeholder color
                                    child:
                                        Icon(Icons.error), // placeholder icon
                                  );
                                },
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () async {
                          await loadImageUrl();

                          if (urlPath.isNotEmpty) {
                            usersCollection
                                .doc(currentUser.email)
                                .update({'photo': urlPath});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // user email
              LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = 1000;
                  return Center(
                    child: SizedBox(
                      width: constraints.maxWidth > maxWidth
                          ? maxWidth
                          : constraints.maxWidth,
                      child: Column(
                        children: [
                          Text(
                            currentUser.email!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          // user details
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  translation(context).profileDetails,
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          // username
                          MyTextBox(
                            text: userData['username'],
                            sectionName:
                                translation(context).homeUsernameHintText,
                            onPressed: () => editField('username'),
                          ),
                          // bio
                          MyTextBox(
                            text: userData['bio'],
                            sectionName: translation(context).biographyHintText,
                            onPressed: () => editField('bio'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error => ${snapshot.error}'),
          );
        }
        return Container();
      },
    );
  }
}*/

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/bloc/routing_bloc.dart';
import 'package:my_web_app/classes/language_constants.dart';
import 'package:my_web_app/features/user_auth/presentation/widgets/text_box.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../utils/image_loader.dart';
import '../../../../utils/path_util.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  late String field = '';

  //all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    //update in firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  late String urlPath = '';
  final String path = 'profile';

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadImageUrl() async {
    try {
      final url = await ImageLoader().openPicker(path);
      setState(() {
        urlPath = url;
      });
    } catch (error) {
      print("Error loading image: $error");
      // Handle error gracefully, such as displaying an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(60.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<DocumentSnapshot>(
                    stream: usersCollection.doc(currentUser.uid).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            height: screenHeight * 0.55,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                )
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.01),
                              //border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: screenHeight * 0.15,
                                  width: screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Stack(
                                      children: [
                                        userData['photo'] != ''
                                            ? Center(
                                                child: Container(
                                                  height: screenWidth * 0.05,
                                                  width: screenWidth * 0.05,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      // Fit the image to cover the entire circle
                                                      image: NetworkImage(
                                                          userData['photo'] ??
                                                              ''),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Container(
                                                  height: screenWidth * 0.05,
                                                  width: screenWidth * 0.05,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey),
                                                  child: Center(
                                                    child: Container(
                                                      height:
                                                          screenWidth * 0.02,
                                                      width: screenWidth * 0.02,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        Positioned(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add_a_photo,
                                              color: Colors.blueGrey,
                                            ),
                                            onPressed: () async {
                                              await loadImageUrl();

                                              if (urlPath.isNotEmpty) {
                                                usersCollection
                                                    .doc(currentUser.uid)
                                                    .update({'photo': urlPath});
                                              }
                                            },
                                          ),
                                          top: screenHeight * 0.072,
                                          left: screenWidth * 0.085,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => editField('username'),
                                        child: Container(
                                          width: screenWidth * 0.23,
                                          height: screenHeight * 0.07,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Username:',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.012),
                                                    ),
                                                    IconButton(onPressed: () => editField('username'), icon: Icon(Icons.edit, color: Colors.grey.shade400,))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      userData['username'] ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.01,
                                                          color: Colors
                                                              .grey.shade600),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => editField('email'),
                                        child: Container(
                                          width: screenWidth * 0.23,
                                          height: screenHeight * 0.07,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Email:',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.012),
                                                    ),
                                                    IconButton(onPressed: () => editField('username'), icon: Icon(Icons.edit, color: Colors.grey.shade400,))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      userData['email'] ?? '',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.01,
                                                          color: Colors
                                                              .grey.shade600),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.1,
                                        height: screenHeight * 0.04,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade500,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )),
                                        child: TextButton(
                                          onPressed: () {
                                            context.read<RoutingBloc>().add(
                                                StoreEvent(
                                                    userId: currentUser.uid));
                                            context.read<ProductBloc>().add(
                                                UserProductsEvent(
                                                    userId: currentUser.uid));
                                            updateUrl(
                                                '/mainPage/${currentUser.uid}/store');
                                          },
                                          child: Text('Go to Store'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        print('Error => ${snapshot.error}');
                      }
                      return Container();
                    }),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    height: screenHeight * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('Account Status:'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.04,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Suspend',
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Disactivate',
                                          style: TextStyle(
                                              color: Colors.blue.shade900),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.04,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey.withOpacity(0.5),
                                          )),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Activated',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Reviews'),
                                Row(
                                  children: [
                                    Text(
                                      '4.5k',
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                              )
                            ],
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 1),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text('Insights'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Seen by'),
                                    Row(
                                      children: [
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Messages'),
                                    Row(
                                      children: [
                                        Text(
                                          '12',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Icon(
                                          Icons.message,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
