import 'package:authentication_test/pages/authentication/register.dart';
import 'package:authentication_test/pages/main-page.dart';
import 'package:authentication_test/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailContraller = TextEditingController();
  final TextEditingController _passwordContraller = TextEditingController();

  @override
  void dispose() {
    _emailContraller.dispose();

    _passwordContraller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailContraller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: Text("Email")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter an email";
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return "Enter a valid Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _passwordContraller,
                    obscureText: true,
                    decoration: InputDecoration(label: Text('Password')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 charactors ";
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Register"),
                    ),
                  ),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Create a account,Register Page",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
