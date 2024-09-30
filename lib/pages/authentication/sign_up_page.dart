import 'package:flutter/material.dart';
import 'package:remote_nomads/widgets/authentication/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Sign Up"),
              const SignUpForm(),
              TextButton(
                child: const Text(
                  "Already a Remote Nomad? Sign In here!",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
