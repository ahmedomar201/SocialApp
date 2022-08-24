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
    apiKey: 'AIzaSyADWAZ7U0RMkVj9pFxvcdoZqfJtJbthRzw',
    appId: '1:1096464854227:web:7336dccd13985355b4f826',
    messagingSenderId: '1096464854227',
    projectId: 'social-app-f3760',
    authDomain: 'social-app-f3760.firebaseapp.com',
    storageBucket: 'social-app-f3760.appspot.com',
    measurementId: 'G-R171FJ1VCK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0iTkXnG0eVwMhHenE79z-YEw_VhwGaI8',
    appId: '1:1096464854227:android:aa90d166f9816d5ab4f826',
    messagingSenderId: '1096464854227',
    projectId: 'social-app-f3760',
    storageBucket: 'social-app-f3760.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmNcJ-vONnPUyBvilRGDRTzPxTDjodoVA',
    appId: '1:1096464854227:ios:a4e8cce8e289acbfb4f826',
    messagingSenderId: '1096464854227',
    projectId: 'social-app-f3760',
    storageBucket: 'social-app-f3760.appspot.com',
    iosClientId:
        '1096464854227-4jmr4p0jvurhjrrrhn3jrbonufb2f7vh.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialapp',
  );
}
