
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Initialize Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAKfZg6O8cRN4iHp94aTJppfb6I0w42ipI",
        authDomain: "flutternewsapp-81dcc.firebaseapp.com",
        projectId: "flutternewsapp-81dcc",
        storageBucket: "flutternewsapp-81dcc.firebasestorage.app",
        messagingSenderId: "510109106554",
        appId: "1:510109106554:web:40b02da9a9a394fd3dd6c3",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  //  Register AuthController
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Flutter App',
      initialRoute: '/',
      getPages: AppRoutes.pages,
    );
  }
}
