import 'package:flutter/material.dart';
import 'package:homer_app/authentication/per_info_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateFrom(){
    if(nameTextEditingController.text.length<3) {
      Fluttertoast.showToast(msg: 'Tên Của Đối Tác Phải Nhiều Hơn 3 Ký Tự' );
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Không Bỏ qua Số Điện Thoại.");
    }
    else if(idTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Không Bỏ Số Căn Cước/Căn Cước Công Dân/Chứng Minh Nhân Dân.");
    }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Mật Khẩu Phải Nhiều Hơn 6 Ký Tự.");
    }
    // else
    // {
    //   saveDriverInfoNow();
    // }
  }
<<<<<<< HEAD

  saveHouserKeeperInfoNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "Đang Xữ Lý, Vui Lòng Chờ...");
      },
    );

    try {
      final User? firebaseUser = (await firebaseAuthAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )).user;

      if (firebaseUser != null) {
        Map housekeeperMap = {
          "id": firebaseUser.uid,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
          "idCard": idTextEditingController.text.trim(),
        };

        DatabaseReference housekeeperRef = FirebaseDatabase.instance.ref().child("Housekeeper");
        housekeeperRef.child(firebaseUser.uid).set(housekeeperMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Tài khoản Tạo Thành Công");

        Navigator.push(context, MaterialPageRoute(builder: (c) => const PerInfoScreen()));
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Tài Khoản Tạo Thất Bại.");
      }
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Lỗi: $error");
    }
  }
=======
>>>>>>> parent of bdb1abb (1. fix fontend, and push regit data to firebase but not had reeltime database reup)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('images/logo1.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Đăng ký một đối tác của Homer',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Tên Đối Tác',
                  hintText: 'Tên Đối Tác',
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Số Điện Thoại',
                  hintText: 'Số Điện Thoại',
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
                  //     MaterialPageRoute(builder: (c) => const PerInfoScreen()));
                  validateFrom();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child: const Text(
                  "Tạo Tài Khoản",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
