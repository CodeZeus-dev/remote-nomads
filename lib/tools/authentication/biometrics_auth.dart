import 'package:local_auth/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

final LocalAuthentication auth = LocalAuthentication();

Future<bool> checkBiometrics() async {
  bool canCheckBiometrics;
  try {
    canCheckBiometrics = await auth.canCheckBiometrics;
  } catch (e) {
    canCheckBiometrics = false;
  }
  return canCheckBiometrics;
}

Future<bool> authenticateWithBiometrics() async {
  bool authenticated = false;
  try {
    authenticated = await auth.authenticate(
      localizedReason: 'Please authenticate to access the app',
      options: const AuthenticationOptions(
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
      ),
    );
  } catch (e) {
    print(e);
  }

  return authenticated;
}

Future<void> signInWithBiometrics() async {
  bool authenticated = await authenticateWithBiometrics();
  if (authenticated) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('User already authenticated: ${user.email}');
      // Proceed with granting access to the app
    } else {
      print('No authenticated user found');
      // Redirect to Firebase authentication flow if needed
    }
  }
}
