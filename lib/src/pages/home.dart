import 'package:carryon/src/components/button.dart';
import 'package:carryon/src/pages/auth/services.dart';
import 'package:carryon/src/pages/welcome.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void signOut(BuildContext context) async {
    await AuthServices().signOutUser();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const Welcome();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ClElevatedButtonPrimary(
          text: "Logout",
          onPressed: () => signOut(context),
        ),
      ),
    );
  }
}
