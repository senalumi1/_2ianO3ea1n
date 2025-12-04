import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAYf875KFLu9SDAhtge3BpZPWZ4mQxkhBo",
            authDomain: "teset1-0zhe7h.firebaseapp.com",
            projectId: "teset1-0zhe7h",
            storageBucket: "teset1-0zhe7h.firebasestorage.app",
            messagingSenderId: "1037041585543",
            appId: "1:1037041585543:web:357bd34d93261a2e9a1722",
            measurementId: "G-0QZEZW5TMN"));
  } else {
    await Firebase.initializeApp();
  }
}
