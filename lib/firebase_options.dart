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
    apiKey: 'AIzaSyBPgqwLWdaAz9acGLy2Hwjx0xid1GUUwQY',
    appId: '1:729259964518:web:9ad41b2314d31839ed15a7',
    messagingSenderId: '729259964518',
    projectId: 'aspiring-minds-backend',
    authDomain: 'aspiring-minds-backend.firebaseapp.com',
    databaseURL: 'https://aspiring-minds-backend-default-rtdb.firebaseio.com',
    storageBucket: 'aspiring-minds-backend.appspot.com',
    measurementId: 'G-85K97KC72W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2bL3NYOwQ3qpsxL3d1frDqLeh_B0rH0M',
    appId: '1:729259964518:android:458487cef139f346ed15a7',
    messagingSenderId: '729259964518',
    projectId: 'aspiring-minds-backend',
    databaseURL: 'https://aspiring-minds-backend-default-rtdb.firebaseio.com',
    storageBucket: 'aspiring-minds-backend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXu3dZus8mfvjHghAp1L71pHJdCekqP9w',
    appId: '1:729259964518:ios:6b1a29326dd6cc7bed15a7',
    messagingSenderId: '729259964518',
    projectId: 'aspiring-minds-backend',
    databaseURL: 'https://aspiring-minds-backend-default-rtdb.firebaseio.com',
    storageBucket: 'aspiring-minds-backend.appspot.com',
    iosClientId: '729259964518-s61r88qt421840bem3bncb7vk5lp68hp.apps.googleusercontent.com',
    iosBundleId: 'com.example.aspirantMinds',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXu3dZus8mfvjHghAp1L71pHJdCekqP9w',
    appId: '1:729259964518:ios:de429a9bbee5f1c5ed15a7',
    messagingSenderId: '729259964518',
    projectId: 'aspiring-minds-backend',
    databaseURL: 'https://aspiring-minds-backend-default-rtdb.firebaseio.com',
    storageBucket: 'aspiring-minds-backend.appspot.com',
    iosClientId: '729259964518-aqoojuvmv7mc5sjq8dj5drv22utan1bf.apps.googleusercontent.com',
    iosBundleId: 'com.example.aspirantMinds.RunnerTests',
  );
}
