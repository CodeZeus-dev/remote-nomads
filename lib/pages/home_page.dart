import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_nomads/pages/authentication/sign_in_page.dart';
import 'package:remote_nomads/pages/authentication/sign_up_page.dart';
import 'package:remote_nomads/pages/quote_page.dart';
import 'package:remote_nomads/pages/splash_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Remote Nomads",
      routes: {
        "/signin": (context) => const SignInPage(),
        "/signup": (context) => const SignUpPage(),
        "/quote": (context) => const QuotePage(),
        "/splash": (context) => const SplashPage(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage();
          }

          if (!snapshot.hasData) {
            return const SignInPage();
          }

          return const QuotePage();
        },
      ),
    );
  }
}
