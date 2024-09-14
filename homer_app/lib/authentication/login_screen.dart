import 'package:flutter/material.dart';
import 'package:homer_app/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('images/logo1.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Đăng Nhập đối tác của Homer',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: idTextEditingController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Căn Cước/ Căn Cước Công Dân/ Chứng Minh Nhân Dân',
                hintText: 'Căn Cước/ Căn Cước Công Dân/ Chứng Minh Nhân Dân',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintStyle: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 10,
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            TextField(
              controller: passwordTextEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Mật Khẩu',
                hintText: 'Mật Khẩu',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintStyle: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 10,
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (c) => PerInfoScreen()));
                // validateForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: const Text(
                "Đăng Nhập",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>const SignUpScreen()));
                },
                child: const Text(
                  'Nếu Chưa Có Tài Khoản? Đăng Ký Tại Đây.',
                  style: TextStyle(
                    color: Colors.red,

                  ),
                ))
          ],
        ),
      ),
    );
  }
}
