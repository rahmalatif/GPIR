import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyAyZJLTCQKHCuUN45e7R6erGKvUeo1oYGY",
        authDomain: "gp-idearecommender.firebaseapp.com",
        projectId: "gp-idearecommender",
        storageBucket: "gp-idearecommender.firebasestorage.app",
        messagingSenderId: "177169958652",
        appId: "1:177169958652:web:3bf9b5b4b49a4ff2df7979",
      );
    } else {
      throw UnsupportedError('Not supported');
    }
  }
}