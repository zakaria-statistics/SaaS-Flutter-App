import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../classes/language_constants.dart';
import '../../../../global/common/toast.dart';
import '../../fire_auth_impl/fire_auth_services.dart';
import '../widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                                          controller: _usernameController,
                                          hintText:
                                          translation(context).homeUsernameHintText,
                                          isPasswordField: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.35,
                                        child: FormContainerWidget(
                                          controller: _emailController,
                                          hintText:
                                          translation(context).loginEmailHintText,
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
                                          hintText:
                                          translation(context).loginPasswordHintText,
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
                                            _signUp();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 66,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: isSigningUp
                                                  ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                                  : Text(
                                                translation(context).signUpButton,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.05,
                                      ),
                                      Row (
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(translation(context).loginDontHaveAccountText, style: TextStyle(color: Colors.grey),),
                                          SizedBox(
                                            width: constraints.maxWidth * 0.003,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context).go('/login');
                                            },
                                            child: Text(
                                              translation(context).loginButton,
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
              )
            ],
          );
        },
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(username, email, password);

    setState(() {
      isSigningUp = false;
    });

    if (user != null) {
      showToast(message: translation(context).signUpSuccessMessage);
      GoRouter.of(context).go("/login");
    } else {
      showToast(message: "Some error happened");
    }
  }
}
