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
    apiKey: 'AIzaSyCdG73q0kSNwB9Ohg_Jrt4fBKvd22H2Y-k',
    appId: '1:4406269426:web:d1b2ab91d39ce5af4b476b',
    messagingSenderId: '4406269426',
    projectId: 'datn-c5a0a',
    authDomain: 'datn-c5a0a.firebaseapp.com',
    storageBucket: 'datn-c5a0a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC1mnkn7fM9x5oJ_9rZZdqxvHLQ5rNo6U',
    appId: '1:4406269426:android:681b6eb4ac7690d84b476b',
    messagingSenderId: '4406269426',
    projectId: 'datn-c5a0a',
    storageBucket: 'datn-c5a0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSN1M7dVaIjSf89f6-ripjzye_7nJibpw',
    appId: '1:4406269426:ios:e11f35166a6040714b476b',
    messagingSenderId: '4406269426',
    projectId: 'datn-c5a0a',
    storageBucket: 'datn-c5a0a.appspot.com',
    androidClientId: '4406269426-2i9s4h8umrg5krdm42ookd325dh0h923.apps.googleusercontent.com',
    iosClientId: '4406269426-sb94mu3m1cb08j3gld86hbvva4p1rr11.apps.googleusercontent.com',
    iosBundleId: 'com.example.clientUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSN1M7dVaIjSf89f6-ripjzye_7nJibpw',
    appId: '1:4406269426:ios:e11f35166a6040714b476b',
    messagingSenderId: '4406269426',
    projectId: 'datn-c5a0a',
    storageBucket: 'datn-c5a0a.appspot.com',
    androidClientId: '4406269426-2i9s4h8umrg5krdm42ookd325dh0h923.apps.googleusercontent.com',
    iosClientId: '4406269426-sb94mu3m1cb08j3gld86hbvva4p1rr11.apps.googleusercontent.com',
    iosBundleId: 'com.example.clientUser',
  );
}
