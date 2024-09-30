import 'package:flutter/material.dart';

/*
  This page is used as an intermediary between the
  authentication pages and the user profile page.

  It is introduced in home_page.dart in StreamBuilder.
*/

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
