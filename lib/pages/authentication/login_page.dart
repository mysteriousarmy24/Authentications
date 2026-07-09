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

  bool _isLoading = false;
  Future<void> _signWithEmailpassword({
    required String email,
    required String password,
  }) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await AuthServices().signWithEmailPasword(
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error registering user: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //google
  // Future<void> _signWithGoogle() async {
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await AuthServices().signWithgoogle();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => MainPage()),
  //     );

  //     print("Loged in with google");
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: Text('Error login user: $e'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  //git hub
  Future<void> _signWithGithub() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await AuthServices().signWithGitHub();
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

      print("Created Acc with email");
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error signin with github user: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signWithEmailpassword(
                            email: _emailContraller.text.trim(),
                            password: _passwordContraller.text.trim(),
                          );
                        }
                      },
                      // child: Text("Login"),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text("Login"),
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
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: _signWithGoogle,
                  //     child: Text("Google"),
                  //   ),
                  // ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _signWithGithub,
                      child: Text("Git Hub"),
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
