import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServices {
  final FirebaseApp _app = Firebase.app();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> generateUserSecrets() async {
    final response = await http
        .get(Uri.parse("https://random-word-api.herokuapp.com/word?number=16"));
    if (response.statusCode == 200) {
      final List<String> words = jsonDecode(response.body).cast<String>();
      return words;
    } else {
      throw Exception("Failed to generate user secrets");
    }
  }

  void validateUsername({
    required String username,
  }) {
    if (username.isEmpty) {
      throw Exception("Username cannot be empty");
    }

    if (!RegExp(r"^[a-zA-Z0-9_.-]*$").hasMatch(username)) {
      throw Exception(
          "Username can only contain letters, numbers, hyphens, underscores, and dots");
    }

    if (!RegExp(r"^[a-zA-Z]").hasMatch(username)) {
      throw Exception("Username should start with a letter");
    }

    if (RegExp(r"[-_.]$").hasMatch(username)) {
      throw Exception(
          "Username should not end with a hyphen, underscore, or dot");
    }
  }

  void validatePassword({
    required String password,
    String? confirmPassword,
  }) {
    if (password.isEmpty) {
      throw Exception("Password cannot be empty");
    }

    if (password.length < 8) {
      throw Exception("Password should be at least 8 characters long");
    }

    if (confirmPassword != null) {
      if (confirmPassword.isEmpty) {
        throw Exception("Confirm password cannot be empty");
      }

      if (password != confirmPassword) {
        throw Exception("Passwords do not match");
      }
    }
  }

  Future<String> signUpUser({
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      validateUsername(username: username);
      validatePassword(password: password, confirmPassword: confirmPassword);

      final String email = "$username@carryon.vilfik.com";

      List<String> secrets = await generateUserSecrets();

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "username": username,
        "email": email,
        "_secrets": secrets,
      });

      return "true";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInUser({
    required String username,
    required String password,
  }) async {
    try {
      validateUsername(username: username);
      validatePassword(password: password);

      final String email = "$username@carryon.vilfik.com";

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "true";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}
