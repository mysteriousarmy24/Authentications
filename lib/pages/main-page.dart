import 'package:authentication_test/pages/authentication/authendication.dart';
import 'package:authentication_test/services/auth_services.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  //store user data
  final String userId = AuthServices().getUserDetails()?.uid ?? "Unkown";

  Future<void> _signedOut(BuildContext context) async {
    try {
      await AuthServices().signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthendicationPage()),
      );
    } catch (error) {
      print("Error in sin out $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("User ID: $userId")),
          ElevatedButton(
            onPressed: () => _signedOut(context),
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
