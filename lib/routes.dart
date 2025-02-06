import 'package:get/get.dart';
import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'screens/home.dart';
import 'screens/first_screen.dart';
import 'screens/main_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => FirstScreen()), // First Screen
    GetPage(name: '/login', page: () => LoginScreen()), // Login Screen
    GetPage(name: '/signup', page: () => SignUpScreen()), // Sign-Up Screen
     GetPage(name: '/main', page: () => MainScreen()), // Main Screen with footer
  ];
}

