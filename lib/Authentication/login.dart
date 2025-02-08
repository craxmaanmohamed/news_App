import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4a65f2),
              ),
            ),
            SizedBox(height: 44),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 34),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 34 ),
            ElevatedButton(
              
              onPressed: () {
                _authController.login(
                  _emailController.text,
                  _passwordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4a65f2),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
