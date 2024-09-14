import 'package:homer_app/authentication/per_info_screen.dart';
import 'package:homer_app/global/global.dart';
import 'package:homer_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: 'Tên Của Đối Tác Phải Nhiều Hơn 3 Ký Tự');
    } else if (emailTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Không Bỏ qua Email.");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Không Bỏ qua Số Điện Thoại.");
    } else if (idTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Không Bỏ Số Căn Cước/Căn Cước Công Dân/Chứng Minh Nhân Dân.");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Mật Khẩu Phải Nhiều Hơn 6 Ký Tự.");
    } else {
      saveHouserKeeperInfoNow();
    }
  }

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset('images/logo1.png', height: 120),
              const SizedBox(height: 20),
              const Text(
                'Đăng ký đối tác Homer',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: nameTextEditingController,
                label: 'Tên Đối Tác',
                hint: 'Nhập tên của bạn',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: emailTextEditingController,
                label: 'Email',
                hint: 'Nhập địa chỉ email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: phoneTextEditingController,
                label: 'Số Điện Thoại',
                hint: 'Nhập số điện thoại',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: idTextEditingController,
                label: 'Số CCCD/CMND',
                hint: 'Nhập số căn cước hoặc CMND',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: passwordTextEditingController,
                label: 'Mật Khẩu',
                hint: 'Nhập mật khẩu',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Tạo Tài Khoản",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}