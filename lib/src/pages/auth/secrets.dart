import 'package:carryon/src/components/text.dart';
import 'package:flutter/material.dart';

class AuthSecrets extends StatelessWidget {
  final List<String> secrets;

  const AuthSecrets({
    required this.secrets,
    super.key,
  });

  // if not secrets, navigate to home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/secrets.png",
                width: 156,
                cacheHeight: 156,
                height: 156,
              ),
            ),
            const SizedBox(height: 24),
            const Center(child: ClTitle("Secure you Account")),
            const SizedBox(height: 24),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClSubTitle("Hi @username"),
                ClSubTitle("Welcome to Carry On!"),
                SizedBox(height: 16),
                ClSubTitle(
                  "Here we believe in anonymity. You don't need to share any of your personal details.\n\nSo, incase you forget your password, we can't help you. But don't worry, we have secret codes for that.\n\nJust download the secrets and keep them safe. You can always use them to recover your account.",
                  fontSize: 18,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 12),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       ClElevatedButtonPrimary(
      //         text: "Sign in",
      //         onPressed: signInUser,
      //       ),
      //       const SizedBox(
      //         height: 12,
      //       ),
      //       ClTextButtonPrimary(
      //         text: "Don't have an account? Sign up",
      //         onPressed: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return const AuthSignUp();
      //               },
      //             ),
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
