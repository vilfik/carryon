import 'package:carryon/src/components/button.dart';
import 'package:carryon/src/components/input.dart';
import 'package:carryon/src/components/loadstack.dart';
import 'package:carryon/src/components/snack.dart';
import 'package:carryon/src/components/text.dart';
import 'package:carryon/src/pages/auth/services.dart';
import 'package:carryon/src/pages/auth/signin.dart';
import 'package:carryon/src/pages/home.dart';
import 'package:flutter/material.dart';

class AuthSignUp extends StatefulWidget {
  const AuthSignUp({super.key});

  @override
  State<AuthSignUp> createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signUpUser() async {
    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    setState(() {
      isLoading = true;
    });

    String result = await AuthServices().signUpUser(
        username: username,
        password: password,
        confirmPassword: confirmPassword);

    if (result == "true") {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      showSnack(context, result);
    }

    // Implement user registration logic here
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClLoadStack(
      isLoading: isLoading,
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            bottom: false,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24),
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/images/signup.png",
                    width: 156,
                    cacheHeight: 156,
                    height: 156,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: ClTitle("Join the Fun")),
                const SizedBox(height: 8),
                const Center(child: ClSubTitle("We believe in anonymity.")),
                const SizedBox(
                  height: 24,
                ),
                ClInput(
                  controller: usernameController,
                  hint: "Pick a username...",
                  focusNext: true,
                  autoFocus: true,
                  suffix: "@carryon",
                ),
                ClInput(
                    controller: passwordController,
                    hint: "Create a password...",
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    focusNext: true),
                ClInput(
                  controller: confirmPasswordController,
                  hint: "Confirm password...",
                  inputType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClElevatedButtonPrimary(
                  text: "Create Account",
                  onPressed: signUpUser,
                ),
                const SizedBox(
                  height: 12,
                ),
                ClTextButtonPrimary(
                  text: "Already have an account? Sign in",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AuthSignIn();
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
