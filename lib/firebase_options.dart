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
    apiKey: 'AIzaSyBCHwSMJx9AKXwZ5XVMpZSUOb9qK5TwXZI',
    appId: '1:445952624681:web:c638d9dc3f1fe1b815f438',
    messagingSenderId: '445952624681',
    projectId: 'scoutingapp-175ee',
    authDomain: 'scoutingapp-175ee.firebaseapp.com',
    storageBucket: 'scoutingapp-175ee.appspot.com',
    measurementId: 'G-R2DG45679G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU_Xhc5H-LR1isPkX8mE6ZV_mbldrri5k',
    appId: '1:445952624681:android:51a7191f5251636d15f438',
    messagingSenderId: '445952624681',
    projectId: 'scoutingapp-175ee',
    storageBucket: 'scoutingapp-175ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMWumQdL6XcmVOSa3CvKQc4M7D7YOTNAE',
    appId: '1:445952624681:ios:40a7ad15da4d511215f438',
    messagingSenderId: '445952624681',
    projectId: 'scoutingapp-175ee',
    storageBucket: 'scoutingapp-175ee.appspot.com',
    iosClientId: '445952624681-o2v38sv5oq3i892h3lln28hfnbmah0n3.apps.googleusercontent.com',
    iosBundleId: 'com.example.scoutingapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMWumQdL6XcmVOSa3CvKQc4M7D7YOTNAE',
    appId: '1:445952624681:ios:40a7ad15da4d511215f438',
    messagingSenderId: '445952624681',
    projectId: 'scoutingapp-175ee',
    storageBucket: 'scoutingapp-175ee.appspot.com',
    iosClientId: '445952624681-o2v38sv5oq3i892h3lln28hfnbmah0n3.apps.googleusercontent.com',
    iosBundleId: 'com.example.scoutingapp',
  );
}
