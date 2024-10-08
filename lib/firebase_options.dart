// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQ3QHpl_Vi9hf6v-3ysFAZpPSWgN6RwvA',
    appId: '1:283089489439:web:38965aa617bc4a67594f2a',
    messagingSenderId: '283089489439',
    projectId: 'remote-nomads',
    authDomain: 'remote-nomads.firebaseapp.com',
    storageBucket: 'remote-nomads.appspot.com',
    measurementId: 'G-D6SCP135ZS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDC8gs0zcc9pHtC3lwgJllKZLL4wogkqKw',
    appId: '1:283089489439:android:8572ddc7d9443545594f2a',
    messagingSenderId: '283089489439',
    projectId: 'remote-nomads',
    storageBucket: 'remote-nomads.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaaBxFuTugjffIWCw-9_970L20vB9-Yh0',
    appId: '1:283089489439:ios:ace1b14b17aca556594f2a',
    messagingSenderId: '283089489439',
    projectId: 'remote-nomads',
    storageBucket: 'remote-nomads.appspot.com',
    iosClientId: '283089489439-8gogm1h3pemole3cpa03gllkq9etmv36.apps.googleusercontent.com',
    iosBundleId: 'com.aetherion.RemoteNomads',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaaBxFuTugjffIWCw-9_970L20vB9-Yh0',
    appId: '1:283089489439:ios:b707c90d06e7da5a594f2a',
    messagingSenderId: '283089489439',
    projectId: 'remote-nomads',
    storageBucket: 'remote-nomads.appspot.com',
    iosClientId: '283089489439-5al2bqh21f17sr1donc7qepitbifbtft.apps.googleusercontent.com',
    iosBundleId: 'com.example.remoteNomads',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQ3QHpl_Vi9hf6v-3ysFAZpPSWgN6RwvA',
    appId: '1:283089489439:web:c84ca8fe2389561f594f2a',
    messagingSenderId: '283089489439',
    projectId: 'remote-nomads',
    authDomain: 'remote-nomads.firebaseapp.com',
    storageBucket: 'remote-nomads.appspot.com',
    measurementId: 'G-95RTRT3NEW',
  );
}
