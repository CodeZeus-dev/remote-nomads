import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_nomads/tools/authentication/email_password_auth.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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

  Future<void> _signIn() async {
    String? errorMessage;

    if (_formKey.currentState!.validate()) {
      try {
        await signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorMessage = "No user found with this email.";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Incorrect password";
        } else if (e.code == 'invalid-email') {
          errorMessage = "The email address is invalid.";
        } else if (e.code == 'user-disabled') {
          errorMessage = "This user has been disabled.";
        } else if (e.code == 'invalid-credential') {
          errorMessage =
              "The supplied auth credential is incorrect, malformed or has expired.";
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
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return 'Please enter a valid email address.';
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
              if (value == null || value.trim().length < 8) {
                return 'Password must be at least 8 characters long.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _signIn,
              child: const Text("Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}
