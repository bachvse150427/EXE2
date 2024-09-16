import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'meh_info_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text editing controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validate form fields
  void _validateForm() {
    if (_nameController.text.length < 3) {
      _showToast("Tên của đối tác phải nhiều hơn 3 ký tự.");
    } else if (_emailController.text.isEmpty) {
      _showToast("Không bỏ qua email.");
    } else if (_phoneController.text.isEmpty) {
      _showToast("Không bỏ qua số điện thoại.");
    } else if (_passwordController.text.length < 6) {
      _showToast("Mật khẩu phải nhiều hơn 6 ký tự.");
    } else {
      _saveMessyHouseInfo();
    }
  }

  // Display toast message
  void _showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  // Save Messy House info to Firebase
  Future<void> _saveMessyHouseInfo() async {
    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ProgressDialog(message: "Đang xử lý, vui lòng chờ...");
      },
    );

    try {
      // Register user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Prepare housekeeper data
        Map<String, String> messyHouseData = {
          "id": firebaseUser.uid,
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "phone": _phoneController.text.trim(),
        };

        // Save housekeeper data to Firebase Realtime Database
        DatabaseReference messyHouseRef =
        FirebaseDatabase.instance.ref().child("messyHouse");
        await messyHouseRef.child(firebaseUser.uid).set(messyHouseData);

        // Store the current Firebase user globally
        currentFirebaseUser = firebaseUser;

        _showToast("Tài khoản tạo thành công!");

        // Check if the widget is still mounted before using context
        if (!mounted) return;

        // Navigate to the Personal Info Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MehInfoScreen()),
        );
      } else {
        _showToast("Tài khoản tạo thất bại.");
      }
    } on FirebaseAuthException catch (e) {
      // Close progress dialog
      if (!mounted) return;
      Navigator.pop(context);
      _showToast("Lỗi: ${e.message}");
    } catch (e) {
      // Close progress dialog
      if (!mounted) return;
      Navigator.pop(context);
      _showToast("Lỗi không xác định: ${e.toString()}");
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
              Image.asset('images/logo.png', height: 120),
              const SizedBox(height: 20),
              const Text(
                'Đăng ký Là Khách Hàng Của Homer',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _nameController,
                label: 'Tên Của Khách Hàng',
                hint: 'Nhập Tên Của Bạn',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Nhập Địa Chỉ Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Số Điện Thoại',
                hint: 'Nhập Số Điện Thoại',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                label: 'Mật Khẩu',
                hint: 'Nhập Mật Khẩu',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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

  // Reusable text field builder
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
