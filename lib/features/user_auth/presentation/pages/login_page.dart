import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../classes/language_constants.dart';
import '../../../../global/common/toast.dart';
import '../../fire_auth_impl/fire_auth_services.dart';
import '../widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    context.read<RoutingBloc>().add(HomeEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          //double maxWidth = 600;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: 4 * constraints.maxHeight / 5,
                    decoration: BoxDecoration(
                      /*boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 15,
                        )
                      ],*/
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment(-0.85, -0.1),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: constraints.maxHeight,
                                width: 7 * constraints.maxWidth / 16,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    // Fit the image to cover the entire circle
                                    image:
                                        AssetImage('images/login_page.jpg'),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Visit our market',
                                      style: TextStyle(fontSize: 40, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Gain your time',
                                      style: TextStyle(fontSize: 33, color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 5 * constraints.maxHeight / 4,
                                width: 7 * constraints.maxWidth / 16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Align(
                                  alignment: Alignment(0.8, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            height:
                                                constraints.maxHeight / 10,
                                            width: constraints.maxWidth / 10,
                                            image: AssetImage(
                                                'assets/svg/zitech.png'),
                                          ),
                                        ],
                                      ),
                                      Text('Please login to your account'),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.35,
                                        child: FormContainerWidget(
                                          inputType: TextInputType.emailAddress,
                                          controller: _emailController,
                                          hintText: translation(context)
                                              .loginEmailHintText,
                                          isPasswordField: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.35,
                                        child: FormContainerWidget(
                                          controller: _passwordController,
                                          hintText: translation(context)
                                              .loginPasswordHintText,
                                          isPasswordField: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.35,
                                        child: GestureDetector(
                                          onTap: () {
                                            _signIn();
                                          },
                                          child: Container(
                                            width: constraints.maxWidth * 0.15,
                                            height: 66,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: _isSigning
                                                  ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                                  : Text(
                                                translation(context)
                                                    .loginButton,
                                                style: themeData
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                    color:
                                                    Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * 0.15,
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.005,
                                          ),
                                          Text(
                                            'Or Login with',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.005,
                                          ),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.15,
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _signInWithGoogle();
                                              },
                                              child: Container(
                                                width: constraints.maxWidth * 0.15,
                                                height: 66,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.google, color: Colors.white,),
                                                      const SizedBox(width: 5,),
                                                      Text(
                                                        translation(context).loginSignInWithGoogleButton,
                                                        style: themeData.textTheme.bodyMedium?.copyWith(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).go('/mainPage');
                                              },
                                              child: Container(
                                                width: constraints.maxWidth * 0.15,
                                                height: 66,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Guest only",
                                                    style: themeData.textTheme.bodyMedium?.copyWith(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(translation(context).loginDontHaveAccountText, style: TextStyle(color: Colors.grey),),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.003,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context).go('/signUp');
                                            },
                                            child: Text(
                                              translation(context).signUpButton,
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: translation(context).signedSuccessMessage);
      context.go('/mainPage');
    } else {
      showToast(message: "some error occurred");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential credentialUser =
            await _firebaseAuth.signInWithCredential(credential);


        // Check if the user already exists in Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .doc(credentialUser.user?.uid)
            .get();

        // If the user doesn't exist, create a new document with the user's details and redirect to login
        if (!userSnapshot.exists) {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(credentialUser.user?.uid)
              .set({
            'email': credentialUser.user?.email,
            'username': credentialUser.user?.displayName,
            'bio': 'Add a bio here ....',
            'photo': credentialUser.user?.photoURL,
            'postList': []// Initialize with empty string
            //add additional fields as needed
          });
          /*await FirebaseFirestore.instance
              .collection("Users")
              .add({
            'id': credentialUser.user?.uid,
            'email': credentialUser.user?.email,
            'username': credentialUser.user?.displayName,
            'bio': 'Add a biography here ....',
            'photo': credentialUser.user?.photoURL, // Initialize with empty string
            //add additional fields as needed
          });*/
          // Redirect to login
          showToast(message: "user created successfully");
          context.go('/login'); // Assuming your login page route is '/login'
        } else {
          // Navigate to home page
          context.go('/mainPage');
        }
      }
    } catch (e) {
      showToast(message: "some error occurred $e");
    }
  }
}
