import 'package:flutter/material.dart';
import 'package:remote_nomads/tools/authentication/oauth2_auth.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithGoogle();
      },
      child: const Text("Sign In with Google"),
    );
  }
}
