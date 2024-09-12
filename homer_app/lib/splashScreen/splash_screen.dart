import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homer_app/mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);
  @override
  _MySplashScreenState createState() => _MySplashScreenState();

}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer() {
    Timer(const Duration(seconds: 2), () {
      // send user to home screen
      Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
    });
  }
  @override
  void initState(){
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
            const SizedBox(height: 10,),
            const Text(
                'Homer & learn App',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
      
              ),
            ),
          ],
        ),
      ),
    );
  }
}