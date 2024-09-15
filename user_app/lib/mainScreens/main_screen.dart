import 'package:flutter/material.dart';
import 'package:user_app/authentication/login_screen.dart';
import 'package:user_app/global/global.dart';

class MainScreen extends StatefulWidget
{
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: ElevatedButton(
        child: const Text(
            "Đăng xuất"
        ),
        onPressed: ()
        {
          firebaseAuthAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
        },
      ),
    );
  }
}
