// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBGFvNReTjHFxbzHpxhmAoVDOK_vOz-iM0',
    appId: '1:959921168726:web:0f6deb016db91c8ed176f7',
    messagingSenderId: '959921168726',
    projectId: 'fir-application-d5f12',
    authDomain: 'fir-application-d5f12.firebaseapp.com',
    storageBucket: 'fir-application-d5f12.appspot.com',
    measurementId: 'G-QDRZBF6JZN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUn-SFLfvWQklkMGq0JzBJluJ-AYJb_Mc',
    appId: '1:959921168726:android:1a53175f51157719d176f7',
    messagingSenderId: '959921168726',
    projectId: 'fir-application-d5f12',
    storageBucket: 'fir-application-d5f12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPU9lVoDMaHVWW3oOSYvO9gOIwxhcl7-4',
    appId: '1:959921168726:ios:8fe43c893a967c16d176f7',
    messagingSenderId: '959921168726',
    projectId: 'fir-application-d5f12',
    storageBucket: 'fir-application-d5f12.appspot.com',
    iosBundleId: 'com.example.firebaseApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPU9lVoDMaHVWW3oOSYvO9gOIwxhcl7-4',
    appId: '1:959921168726:ios:2fb9778767c1bd89d176f7',
    messagingSenderId: '959921168726',
    projectId: 'fir-application-d5f12',
    storageBucket: 'fir-application-d5f12.appspot.com',
    iosBundleId: 'com.example.firebaseApplication.RunnerTests',
  );
}
