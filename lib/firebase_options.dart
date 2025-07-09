import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:my_todo/secret.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'FirebaseOptions for Web platform is not configured.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'This platform is not supported.',
        );
    }
  }

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: Secret.androidApiKey,
    appId: Secret.androidAppId,
    messagingSenderId: Secret.messagingSenderId,
    projectId: Secret.projectId,
    databaseURL: Secret.databaseUrl,
    storageBucket: Secret.storageBucket,
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: Secret.iosApiKey,
    appId: Secret.iosAppId,
    messagingSenderId: Secret.messagingSenderId,
    projectId: Secret.projectId,
    databaseURL: Secret.databaseUrl,
    storageBucket: Secret.storageBucket,
    iosClientId: Secret.iosClientId,
    iosBundleId: Secret.iosBundleId,
  );
}
