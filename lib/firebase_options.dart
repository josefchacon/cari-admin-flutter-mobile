import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCkt0g_3xVoK6cRowhxNHRPgkAVAt5tDbo',
    appId: '1:1005969701962:web:02a32307583936d4e9bab3',
    messagingSenderId: '1005969701962',
    projectId: 'cari-survey-app',
    authDomain: 'cari-survey-app.firebaseapp.com',
    storageBucket: 'cari-survey-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkt0g_3xVoK6cRowhxNHRPgkAVAt5tDbo',
    appId: '1:1005969701962:android:1005969701962:android:656fd5a7392b8617e9bab3',
    messagingSenderId: '1005969701962',
    projectId: 'cari-survey-app',
    storageBucket: 'cari-survey-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkt0g_3xVoK6cRowhxNHRPgkAVAt5tDbo',
    appId: '1:1005969701962:ios:1005969701962:ios:01414867b022738de9bab3',
    messagingSenderId: '1005969701962',
    projectId: 'cari-survey-app',
    storageBucket: 'cari-survey-app.firebasestorage.app',
    iosBundleId: 'com.example.cariAdminFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkt0g_3xVoK6cRowhxNHRPgkAVAt5tDbo',
    appId: '1:1005969701962:ios:YOUR_IOS_APP_ID',
    messagingSenderId: '1005969701962',
    projectId: 'cari-survey-app',
    storageBucket: 'cari-survey-app.firebasestorage.app',
    iosBundleId: 'com.example.cariAdminFlutter',
  );
}