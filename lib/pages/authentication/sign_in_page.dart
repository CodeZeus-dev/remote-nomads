import 'package:flutter/material.dart';
import 'package:remote_nomads/widgets/authentication/biometrics_sign_in_button.dart';
import 'package:remote_nomads/widgets/authentication/google_sign_in_button.dart';
import 'package:remote_nomads/widgets/authentication/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Sign In"),
              const SignInForm(),
              TextButton(
                child: const Text(
                  "Click here to become a Remote Nomad!",
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
              ),
              const Divider(),
              const GoogleSignInButton(),
              const BiometricsSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
