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

  /// Firebase options for Android.
  ///
  /// These options contain the necessary credentials for connecting to Firebase on Android.
  /// The credentials are secured with the help of environment variables.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment('android_apiKey'),
    appId: String.fromEnvironment('android_appId'),
    messagingSenderId: String.fromEnvironment('android_messagingSenderId'),
    projectId: String.fromEnvironment('android_projectId'),
    storageBucket: String.fromEnvironment('android_storageBucket'),
  );

  /// Firebase options for iOS.
  ///
  /// These options contain the necessary credentials for connecting to Firebase on iOS.
  /// The credentials are secured with the help of environment variables.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment('ios_apiKey'),
    appId: String.fromEnvironment('ios_appId'),
    messagingSenderId: String.fromEnvironment('ios_messagingSenderId'),
    projectId: String.fromEnvironment('ios_projectId'),
    storageBucket: String.fromEnvironment('ios_storageBucket'),
    iosBundleId: String.fromEnvironment('ios_iosBundleId'),
  );
}
