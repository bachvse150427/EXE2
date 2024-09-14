import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homer_app/authentication/login_screen.dart';
// import 'package:homer_app/authentication/signup_screen.dart';
// import 'package:homer_app/mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () {
      // send user to home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const LoginScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo1.png'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '       Homer',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
