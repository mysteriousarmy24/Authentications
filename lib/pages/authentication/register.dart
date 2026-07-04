import 'package:authentication_test/pages/authentication/login_page.dart';
import 'package:authentication_test/pages/main-page.dart';
import 'package:authentication_test/services/auth_services.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailContraller = TextEditingController();
  final TextEditingController _passwordContraller = TextEditingController();
  final TextEditingController _confirmPasswordContraller =
      TextEditingController();

  bool _isLoading = false;
  Future<void> _createWithEmaipassword({
    required String email,
    required String password,
  }) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await AuthServices().registerWithEmailPasword(
        email: email,
        password: password,
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

      print("Created Acc with email");
    } catch (error) {
      print("Error in sign with email & asswords $error");
    }
  }

  @override
  void dispose() {
    _emailContraller.dispose();
    _confirmPasswordContraller.dispose();
    _passwordContraller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
                  TextFormField(
                    controller: _confirmPasswordContraller,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      } else if (_passwordContraller.text != value) {
                        return "Passwords don't match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _createWithEmaipassword(
                            email: _emailContraller.text.trim(),
                            password: _passwordContraller.text.trim(),
                          );
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text("Register"),
                    ),
                  ),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Are you already register,Login Page",
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
