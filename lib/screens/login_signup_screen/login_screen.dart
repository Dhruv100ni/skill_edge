import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_edge/components/landing_page.dart';
import 'package:skill_edge/providers/user_provider.dart';
import 'package:skill_edge/screens/Quiz/quiz_page.dart';
import '../../services/firebase_auth_service.dart';
import '../login_signup_screen/home_screen.dart';
import '../login_signup_screen/signup_screen.dart';
import '/widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/customized_button.dart';
import '/widgets/customized_textfield2.dart';
import '../login_signup_screen/forgot_password.dart';
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const LandingPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Welcome Back! Glad \nto see you again",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              CustomizedTextfield2(
                myController: _emailController,
                hintText: "Enter your Email",
                isPassword: false,
              ),
              CustomizedTextfield(
                myController: _passwordController,
                hintText: "Enter your Password",
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                          color: Color(0xff6A707C),
                          fontSize: 15,
                        )),
                  ),
                ),
              ),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: Colors.black,
                textColor: Colors.white,
                onPressed: () async {
                  //  The else part is not working in the video because we have
                  //  enclosed it in the try catch block. Once we have error in
                  // login the firebase exception is thrown and the codeblock after that
                  // error is skiped and code of catch block is executed.
                  // if we want our else part to be executed we need to get rid from
                  // this try catch or add that code in catch block.

                  try {
                    // await FirebaseAuthService().login(
                    //     _emailController.text.trim(),
                    //     _passwordController.text.trim());
                    await context.read<CurrentUser>().custLogin(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (!mounted) return;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LandingPage();
                      }));
                    }

                    //  This code is gone inside the catch block
                    // which is executed only when we have firebaseexception
                    //  else {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) => AlertDialog(
                    //               title: Text(
                    //                   " Invalid Username or password. Please register again or make sure that username and password is correct"),
                    //               actions: [
                    //                 ElevatedButton(
                    //                   child: Text("Register Now"),
                    //                   onPressed: () {
                    //                     Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                             builder: (context) =>
                    //                                 SignUpScreen()));
                    //                   },
                    //                 )
                    //               ]));

                    // }
                  } on FirebaseException catch (e) {
                    debugPrint("error is ${e.message}");

                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text(
                                    " Invalid Username or password. Please register again or make sure that username and password is correct"),
                                actions: [
                                  ElevatedButton(
                                    child: const Text("Register Now"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen()));
                                    },
                                  )
                                ]));
                  }

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.grey,
                    ),
                    const Text("Or Login with"),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.height * 0.15,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        )),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          // color: Colors.blue,
                        ),
                        onPressed: () async {
                          await FirebaseAuthService().logininwithgoogle();

                          if (FirebaseAuth.instance.currentUser != null) {
                            if (!mounted) return;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            throw Exception("Error");
                          }
                        },
                      ),
                    ),
                    Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            // color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LandingPage()));
                          },
                        ))
                  ],
                ),
              ),

              new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  Text("Don't have an account?",
                      style: TextStyle(
                        color: Color(0xff1E232C),
                        fontSize: 15,
                      )),
                  Text("  Register Now",
                      style: TextStyle(
                        color: Color(0xff35C2C1),
                        fontSize: 15,
                      )),
                ]),
              )
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(48, 8, 8, 8.0),
              //   child: Row(
              //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: const [
              //       Text("Don't have an account?",
              //           style: TextStyle(
              //             color: Color(0xff1E232C),
              //             fontSize: 15,
              //           )),

              //       Text("  Register Now",

              //           style: TextStyle(
              //             color: Color(0xff35C2C1),
              //             fontSize: 15,
              //           )),
              //     ]

              //   ),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
