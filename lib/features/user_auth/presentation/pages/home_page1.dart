import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/bloc/routing_bloc.dart';
import '../../../../bloc/products_bloc.dart';
import '../backend/entities/user_entity.dart';
import '../widgets/product_card.dart';
import '../widgets/profile_card.dart';


class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  Stream<QuerySnapshot>? usersStream;
  final currentUser = FirebaseAuth.instance.currentUser!;

  List<UserEntity> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsersStream();
  }

  void fetchUsersStream() {
    usersStream = FirebaseFirestore.instance.collection('Users').where(FieldPath.documentId, isNotEqualTo: currentUser.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print('#########################');
    print('Height = ${screenHeight} and Width = ${screenWidth}');
    print('#########################');
    return Container(
        width: double.infinity,
        height: screenWidth < 2000 ? screenHeight * 2 : screenHeight * 1.1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  2000 < M +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            Row(
              mainAxisAlignment: screenWidth > 2000
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    height: screenWidth < 2000
                        ? screenHeight * 0.5
                        : screenHeight * 0.85,
                    width: screenWidth * 0.75,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5.0, left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sellers',
                                style: themeData.textTheme.bodyMedium
                                    ?.copyWith(fontSize: screenWidth * 0.025),
                              ),
                            ],
                          ),
                        ),
                        //header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0, bottom: 20.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 5),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      fontSize: screenWidth * 0.012,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(
                                              0.5)), // Border color
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 2), // Border color
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(
                                              0.5)), // Border color
                                    ),
                                  ),
                                  cursorColor: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Icon(Icons.search, color: Colors.grey.withOpacity(0.5), size: screenWidth * 0.02,),
                            ),
                            SizedBox(
                              width: screenWidth * 0.5,
                            ),
                          ],
                        ),
//----------------------------------------------------------------------------------------------------------------------
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: usersStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show a loading indicator
                            }

                            final users = snapshot.data?.docs
                                    .map((doc) => UserEntity.fromSnapshot(doc))
                                    .toList() ??
                                [];

                            // Print the username of the first user (for debugging)
                            print(users.isNotEmpty
                                ? users.first.username
                                : 'No users found');

                            return Expanded(
                              flex: 14,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 20.0),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (screenWidth > 2000 &&
                                            screenHeight > 800)
                                        ? 2
                                        : 1,
                                    // Number of columns in the grid
                                    crossAxisSpacing: 30.0,
                                    // Spacing between columns
                                    mainAxisSpacing: 20.0,
                                    // Spacing between rows
                                    childAspectRatio:
                                        1.0, // Aspect ratio of each grid item (width / height)
                                  ),
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    final user = users[index];
                                    // Customize the UI for each user (e.g., display username)
                                    return Container(
                                      height: screenHeight * 0.4,
                                      width: screenWidth * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ),
                                      child: Column(
                                        children: [
                                          // Background container
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      border: Border.all(
                                                        width: screenHeight * 0.0012,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                      color: Colors.blueAccent
                                                  ),
                                                  child: TextButton(
                                                    child: Text(
                                                      'Suspend',
                                                      style: themeData
                                                          .textTheme.bodySmall
                                                          ?.copyWith(
                                                          fontSize: screenWidth *
                                                              0.009,
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      border: Border.all(
                                                        width: screenHeight * 0.0012,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    color: Colors.red,
                                                  ),
                                                  child: TextButton(
                                                    child: Text(
                                                      'Ban',
                                                      style: themeData
                                                          .textTheme.bodySmall
                                                          ?.copyWith(
                                                          fontSize: screenWidth *
                                                              0.009,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      60), // Adjust as needed
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 5,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              backgroundImage:
                                                  NetworkImage(user.photo!),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.01,
                                          ),
                                          Text(
                                            user.username!,
                                            style: themeData
                                                .textTheme.bodySmall!
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize:
                                                        screenWidth * 0.01),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    border: Border.all(
                                                      width: screenHeight * 0.0012,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                    )),
                                                child: TextButton(
                                                  child: Text(
                                                    'Profile',
                                                    style: themeData
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: screenWidth *
                                                                0.009),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    border: Border.all(
                                                      width: screenHeight * 0.0012,
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                    )),
                                                child: TextButton(
                                                  child: Text(
                                                    'Store',
                                                    style: themeData
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                            fontSize: screenWidth *
                                                                0.009),
                                                  ),
                                                  onPressed: () {
                                                    context.read<RoutingBloc>().add(StoreEvent(userId: user.id!));
                                                    context.read<ProductBloc>().add(UserProductsEvent(userId: user.id!));
                                                    updateUrl('/mainPage/${user.id}/store');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Profile Button
                                          // User Avatar
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                screenWidth > 2000
                    ? Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.01),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1
                                ),
                              ),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      bottom: 5.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Most Selling Products',
                                          style: themeData.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.015),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProductCard(
                                      title: 'Work Station',
                                      imageUrl: 'assets/computer.png',
                                      order: 90,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProductCard(
                                      title: 'Work Station',
                                      imageUrl: 'assets/computer1.jpg',
                                      order: 90,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProductCard(
                                      title: 'Work Station',
                                      imageUrl: 'assets/computer8.jpg',
                                      order: 90,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5)
                                )
                              ),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      bottom: 5.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Weekly Top Sellers',
                                          style: themeData.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.015),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProfileCard(
                                      name: 'James Nash',
                                      sales: 60,
                                      avatarImageUrl: 'assets/images.jpeg',
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProfileCard(
                                      name: 'James Nash',
                                      sales: 60,
                                      avatarImageUrl: 'assets/anonyme_prof.png',
                                      onPressed: () {},
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: ProfileCard(
                                      name: 'James Nash',
                                      sales: 60,
                                      avatarImageUrl: 'assets/images1.jpeg',
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1200 < M < 2000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            (screenWidth < 2000 && screenWidth > 1200)
                ? Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.05),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.25,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  left: screenWidth * 0.01,
                                  bottom: screenHeight * 0.005),
                              child: Row(
                                children: [
                                  Text('Weekly top sellers'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProfileCard(
                                    name: 'James Nash',
                                    sales: 60,
                                    avatarImageUrl: 'assets/anonyme_prof.png',
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProfileCard(
                                    name: 'James Nash',
                                    sales: 60,
                                    avatarImageUrl: 'assets/images.jpeg',
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProfileCard(
                                    name: 'James Nash',
                                    sales: 60,
                                    avatarImageUrl: 'assets/images1.jpeg',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                : Container(),
// ######################################################################################################
            (screenWidth < 2000 && screenWidth > 1200)
                ? Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.05),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        width: screenWidth * 0.75,
                        height: screenHeight * 0.25,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  left: screenWidth * 0.01,
                                  bottom: screenHeight * 0.005),
                              child: Row(
                                children: [
                                  Text('Most selling products'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProductCard(
                                    title: 'Work Station',
                                    imageUrl: 'assets/computer.png',
                                    order: 90,
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProductCard(
                                    title: 'Work Station',
                                    imageUrl: 'assets/computer1.jpg',
                                    order: 90,
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: ProductCard(
                                    title: 'Work Station',
                                    imageUrl: 'assets/computer8.jpg',
                                    order: 90,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                : Container(),

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ M <= 1200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            screenWidth <= 1200 //
                ? Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Weekly Top Sellers',
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          ProfileCard(
                            name: 'James Nash',
                            sales: 60,
                            avatarImageUrl: 'assets/images1.jpeg',
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          ProfileCard(
                            name: 'James Nash',
                            sales: 60,
                            avatarImageUrl: 'assets/images.jpeg',
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          ProfileCard(
                            name: 'James Nash',
                            sales: 60,
                            avatarImageUrl: 'assets/images1.jpeg',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            screenWidth <= 1200 //
                ? Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Most selling products',
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.015),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: ProductCard(
                              title: 'Work Station',
                              imageUrl: 'assets/computer.png',
                              order: 90,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: ProductCard(
                              title: 'Work Station',
                              imageUrl: 'assets/computer1.jpg',
                              order: 90,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: ProductCard(
                              title: 'Work Station',
                              imageUrl: 'assets/computer8.jpg',
                              order: 90,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );
  }
}


void updateUrl(String url) {
  window.history.pushState({}, '', url);
}