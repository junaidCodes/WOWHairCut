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
    apiKey: 'AIzaSyAHkgRZVsWGvzRDNQU7aaoZOmqLxAJPojQ',
    appId: '1:996974133837:web:f62499f847ead2e19dd204',
    messagingSenderId: '996974133837',
    projectId: 'haircut-d6819',
    authDomain: 'haircut-d6819.firebaseapp.com',
    storageBucket: 'haircut-d6819.appspot.com',
    measurementId: 'G-8QG8HQ3CJ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtFLFUcPLAw3uUKzUkVWHD2Ei0ocj8hDo',
    appId: '1:996974133837:android:ed9d21104e9f1d399dd204',
    messagingSenderId: '996974133837',
    projectId: 'haircut-d6819',
    storageBucket: 'haircut-d6819.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtQCWwmfnJ897skqjozRQ2b5zk9w1sZjo',
    appId: '1:996974133837:ios:76ec93e1aeaec3729dd204',
    messagingSenderId: '996974133837',
    projectId: 'haircut-d6819',
    storageBucket: 'haircut-d6819.appspot.com',
    iosBundleId: 'com.example.wowcut',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtQCWwmfnJ897skqjozRQ2b5zk9w1sZjo',
    appId: '1:996974133837:ios:ef7a5b1f2b70f0609dd204',
    messagingSenderId: '996974133837',
    projectId: 'haircut-d6819',
    storageBucket: 'haircut-d6819.appspot.com',
    iosBundleId: 'com.example.wowcut.RunnerTests',
  );
}
