import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/RaziinLogo.png',
              width: 400,
              height: 400,
            ),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4a65f2),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4a65f2),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
