import 'package:homer_app/global/global.dart';
import 'package:homer_app/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';


class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}



class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text(
          "Đăng Xuất",
        ),
        onPressed: ()
        {
          firebaseAuthAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        },
      ),
    );
  }
}
