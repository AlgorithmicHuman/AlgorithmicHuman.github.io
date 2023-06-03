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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD8RrPpyqNZffa7_dRnm3sLuJ5XGhfVDXw',
    appId: '1:719192431708:web:af9b8269298d60a95ada99',
    messagingSenderId: '719192431708',
    projectId: 'islamify-1',
    authDomain: 'islamify-1.firebaseapp.com',
    storageBucket: 'islamify-1.appspot.com',
    measurementId: 'G-LZFLHYWT09',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKlCo2vX7vlxmr3X0-Dq03jF8jBVU-Rm0',
    appId: '1:719192431708:android:5f15869a94fce5bd5ada99',
    messagingSenderId: '719192431708',
    projectId: 'islamify-1',
    storageBucket: 'islamify-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDl2kG6-TT0YbdEvj7D9SB4DOufMFjmcvA',
    appId: '1:719192431708:ios:8f584ba0208b90835ada99',
    messagingSenderId: '719192431708',
    projectId: 'islamify-1',
    storageBucket: 'islamify-1.appspot.com',
    androidClientId: '719192431708-a1v1r2p3kefl0nmos59ck4su2c3agrtq.apps.googleusercontent.com',
    iosClientId: '719192431708-huiuo1a89iasmudpn4chbn1amm4krh47.apps.googleusercontent.com',
    iosBundleId: 'com.example.islamifyAdmin',
  );
}