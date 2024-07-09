import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_web_app/features/user_auth/presentation/pages/my_drawer.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../classes/language_constants.dart';
import '../widgets/footer.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/navbar_item.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: const CustomDrawer(),
      drawer: const MenuDrawer(),
      body: BlocListener<RoutingBloc, RoutingState>(
        listener: (context, state) {
          _scrollController.jumpTo(0);
        },
        child: BlocBuilder<RoutingBloc, RoutingState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  //pinned: true,
                  delegate: TopBarDelegate(
                    minHeight: screenHeight * 0.09,
                    maxHeight: screenHeight * 0.09,
                    child: Header(screenHeight: screenHeight),
                  ),
                  //floating: true,
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<RoutingBloc, RoutingState>(
                    builder: (context, state) {
                      print('item state ${state.headerItem.title}');
                      return state.widget;
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: buildFooter(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        color: Colors.blue.shade600,//Color(0xFF0573f0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;

            return Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  screenWidth > 1500
                      ? Row(
                          children: [
                            SizedBox(width: screenWidth / 25),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.045,
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/svg/zitech_white_name_logo.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth / 15),
                            NavItem(
                              icon: Icons.home,
                              routingEvent: HomeEvent(),
                              id: 1,
                              title: translation(context).homePageTitle,
                              path: '/mainPage/home',
                            ),
                            SizedBox(width: screenWidth / 15),
                            NavItem(
                              productEvent: AllProductsEvent(),
                              icon: Icons.shopping_cart,
                              routingEvent: ProductsEvent(),
                              id: 2,
                              title: translation(context).productsTitle,
                              path: '/mainPage/products',
                            ),
                            SizedBox(width: screenWidth / 15),
                            NavItem(
                              icon: Icons.help,
                              routingEvent: AboutEvent(),
                              id: 3,
                              title: translation(context).about,
                              path: '/mainPage/about',
                            ),
                            SizedBox(width: screenWidth / 15),
                          ],
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 20.0),
                          child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: screenWidth * 0.03,
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: screenWidth / 10),
                      const ProfileButton(),
                      SizedBox(width: screenWidth / 30),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TopBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  TopBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}

Widget buildNavItem(BuildContext context, IconData icon, RoutingEvent event,
    int id, String title, String path) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return BlocBuilder<RoutingBloc, RoutingState>(
    builder: (context, state) {
      final bool isSelected = state.headerItem.id == id;

      return InkWell(
        borderRadius: BorderRadius.circular(100),
        radius: 80,
        onTap: () {
          context.read<RoutingBloc>().add(event);
          print('path = ${state.headerItem.title}');
          updateUrl(path);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: screenHeight * 0.03,
              color: isSelected
                  ? Colors.white.withOpacity(0.9)
                  : Colors.white.withOpacity(0.7),
            ),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.018,
              ),
            ),
            SizedBox(height: screenHeight * 0.001),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: isSelected,
              child: Container(
                height: screenHeight * 0.003,
                width: screenWidth * 0.023,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child: FirebaseAuth.instance.currentUser == null
                ? IconButton(
                    onPressed: () {
                      _signOut(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  )
                : const Center(
                    child: ProfileImage(),
                  ),
          ),
        );
      },
    );
  }

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      GoRouter.of(context).go('/login');

      Navigator.of(context)
          .popUntil((route) => route.settings.name == '/login');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translation(context).homeSignOutSuccessMessage)),
      );
    } catch (e) {
      print("Sign out failed: $e");
    }
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print("Error loading image: ${snapshot.error}");
          return const Icon(Icons.error, color: Colors.white);
        } else {
          String? imageUrl = snapshot.data!['photo'] as String?;
          return imageUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 26,
                )
              : const Icon(Icons.error, color: Colors.white);
        }
      },
    );
  }
}

void updateUrl(String url) {
  window.history.pushState({}, '', url);
}
