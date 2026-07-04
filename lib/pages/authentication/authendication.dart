import 'package:authentication_test/pages/main-page.dart';
import 'package:authentication_test/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthendicationPage extends StatelessWidget {
  const AuthendicationPage({super.key});

  //annonimous login
  Future<void> _annonimousLogin(BuildContext context) async {
    await AuthServices().signInAnnonimouslyWithExceptions();
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Announimous Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _annonimousLogin(context);
          },
          child: Text("Anonymous login"),
        ),
      ),
    );
  }
}
