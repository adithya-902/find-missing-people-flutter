import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/authService.dart';
import '../utils/colors.dart';
import '../widgets/logo.dart';
import '../widgets/text_input_field.dart';
import 'forgotPassword.dart';

class SignInScreen extends StatefulWidget {
  final Function()? onTap;
  const SignInScreen({super.key, required this.onTap});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        showErrorMessage("Incorrect E-Mail");
      } else if (err.code == "wrong-password") {
        showErrorMessage("Incorrect Password");
      } else {
        showErrorMessage(err.code);
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white, fontFamily: "montserrat", fontSize: 30),
              ),
            ),
            backgroundColor: theYellowColor,
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                height: 120,
              ),
              const presenting_candor(),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                  textEditingController: _emailcontroller,
                  hintText: "E-Mail",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _passwordcontroller,
                hintText: "Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ForgotPasswordPage();
                        }),
                      );
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: signUserIn,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 60,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: theYellowColor,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Tanker",
                      fontSize: 30,
                      letterSpacing: 5.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => AuthService().signInWithGoogle(),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.white,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google_logo.png',
                          height: 60,
                        ),
                        const Text(
                          "Login with Google",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "yantramanav",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              color: Colors.black),
                        )
                      ]),
                ),
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontFamily: "yantramanav", fontSize: 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "yantramanav",
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
