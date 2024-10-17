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
    apiKey: 'AIzaSyBLb9J8Gjojc7-ZrwLVuqOc80X4RepnShw',
    appId: '1:23301120438:web:d62579ce693ef11bdee117',
    messagingSenderId: '23301120438',
    projectId: 'visitor-management-ba33c',
    authDomain: 'visitor-management-ba33c.firebaseapp.com',
    storageBucket: 'visitor-management-ba33c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1iPSMmdcI4RDPOKQj_4XI9_nVSs8lnqI',
    appId: '1:23301120438:android:326a9f8def63f55edee117',
    messagingSenderId: '23301120438',
    projectId: 'visitor-management-ba33c',
    storageBucket: 'visitor-management-ba33c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbW5QgmbXYn58fKGGF3UDjuNu6QEfP7Uw',
    appId: '1:23301120438:ios:166844e268d3d6b9dee117',
    messagingSenderId: '23301120438',
    projectId: 'visitor-management-ba33c',
    storageBucket: 'visitor-management-ba33c.appspot.com',
    iosBundleId: 'com.example.visitormanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbW5QgmbXYn58fKGGF3UDjuNu6QEfP7Uw',
    appId: '1:23301120438:ios:166844e268d3d6b9dee117',
    messagingSenderId: '23301120438',
    projectId: 'visitor-management-ba33c',
    storageBucket: 'visitor-management-ba33c.appspot.com',
    iosBundleId: 'com.example.visitormanagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLb9J8Gjojc7-ZrwLVuqOc80X4RepnShw',
    appId: '1:23301120438:web:9afab4ca6097071fdee117',
    messagingSenderId: '23301120438',
    projectId: 'visitor-management-ba33c',
    authDomain: 'visitor-management-ba33c.firebaseapp.com',
    storageBucket: 'visitor-management-ba33c.appspot.com',
  );
}