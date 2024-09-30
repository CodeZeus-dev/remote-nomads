import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_nomads/tools/authentication/email_password_auth.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _navigateToProfileHomePage() {
    if (!mounted) return;
    Navigator.of(context).popAndPushNamed('/quote');
  }

  Future<void> _signUp() async {
    String? errorMessage;

    if (_formKey.currentState!.validate()) {
      try {
        User? user = await registerWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );

        if (user != null) {
          _navigateToProfileHomePage();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          errorMessage = "The email address is already in use.";
        } else if (e.code == 'invalid-email') {
          errorMessage = "The email address is invalid.";
        } else if (e.code == 'weak-password') {
          errorMessage = "The password is too weak.";
        } else {
          errorMessage = "An unexpected error occured.";
        }
      }

      if (errorMessage != null) {
        _showSnackBar(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter your email address',
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.email,
              ),
              border: OutlineInputBorder(),
            ),
            controller: emailController,
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'The field cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter your password',
              hintText: 'Password',
              prefixIcon: Icon(
                Icons.password,
              ),
              border: OutlineInputBorder(),
            ),
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 6) {
                return 'The field cannot be empty';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: _signUp,
                child: const Text("Sign Up"),
              )),
        ],
      ),
    );
  }
}
