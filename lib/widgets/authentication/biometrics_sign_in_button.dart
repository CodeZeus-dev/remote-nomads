import 'package:flutter/material.dart';
import 'package:remote_nomads/tools/authentication/biometrics_auth.dart';

class BiometricsSignInButton extends StatelessWidget {
  const BiometricsSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(
      onPressed: signInWithBiometrics,
      child: Text('Sign In with Biometrics'),
    );
  }
}
