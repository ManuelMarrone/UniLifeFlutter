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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ8l3UhT5vX1lylatyPUJXfhMWu2ABMjE',
    appId: '1:222631861257:android:f2327e04014c1f9545acd8',
    messagingSenderId: '222631861257',
    projectId: 'unilife-2fdbf',
    databaseURL: 'https://unilife-2fdbf-default-rtdb.firebaseio.com',
    storageBucket: 'unilife-2fdbf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEgWJa67Vf2_g1rXA8zacvzf9AHBx1CWI',
    appId: '1:222631861257:ios:6b2e019074cfcab145acd8',
    messagingSenderId: '222631861257',
    projectId: 'unilife-2fdbf',
    databaseURL: 'https://unilife-2fdbf-default-rtdb.firebaseio.com',
    storageBucket: 'unilife-2fdbf.appspot.com',
    iosBundleId: 'com.example.unilifeFlutter',
  );
}
