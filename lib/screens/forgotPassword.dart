import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/text_input_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: Text(
                "Password reset link sent! Check your email",
                style: TextStyle(
                  color: Colors.white, fontFamily: "Tanker", fontSize: 30),
              ),
            ),
            backgroundColor: theYellowColor,
          );
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (err) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(err.code);
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
                    color: Colors.white, fontFamily: "Tanker", fontSize: 30),
              ),
            ),
            backgroundColor: theYellowColor,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theYellowColor,
        elevation: 0,
        title: const Text(
          "Password Reset",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Tanker", fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "yantramanav", fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
              textEditingController: _emailcontroller,
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50,
              onPressed: passwordReset,
              color: theYellowColor,
              child: const Text(
                "Reset Password",
                style: TextStyle(fontFamily: "Tanker", fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
