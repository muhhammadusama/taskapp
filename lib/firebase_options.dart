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
    apiKey: 'AIzaSyCXNPb672C86n5kHxMRIQ-JLwI44qI5KIk',
    appId: '1:48096333463:web:906ed8936a917662d2a3d2',
    messagingSenderId: '48096333463',
    projectId: 'personalhome-f172b',
    authDomain: 'personalhome-f172b.firebaseapp.com',
    storageBucket: 'personalhome-f172b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBObm3z6PQId4fHhcEWxlVKGO1XhLtCcvs',
    appId: '1:48096333463:android:91970da5c32ffaabd2a3d2',
    messagingSenderId: '48096333463',
    projectId: 'personalhome-f172b',
    storageBucket: 'personalhome-f172b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCtWezMw3CI8Cq_vve3IjPkpTOsQLsNfw',
    appId: '1:48096333463:ios:6b24b33b399185add2a3d2',
    messagingSenderId: '48096333463',
    projectId: 'personalhome-f172b',
    storageBucket: 'personalhome-f172b.appspot.com',
    iosBundleId: 'com.example.personalHomeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCtWezMw3CI8Cq_vve3IjPkpTOsQLsNfw',
    appId: '1:48096333463:ios:6b24b33b399185add2a3d2',
    messagingSenderId: '48096333463',
    projectId: 'personalhome-f172b',
    storageBucket: 'personalhome-f172b.appspot.com',
    iosBundleId: 'com.example.personalHomeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXNPb672C86n5kHxMRIQ-JLwI44qI5KIk',
    appId: '1:48096333463:web:22e5046223c9d8a8d2a3d2',
    messagingSenderId: '48096333463',
    projectId: 'personalhome-f172b',
    authDomain: 'personalhome-f172b.firebaseapp.com',
    storageBucket: 'personalhome-f172b.appspot.com',
  );
}
