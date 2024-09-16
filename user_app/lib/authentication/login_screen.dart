import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/signup_screen.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Text editing controllers for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validate form fields
  void _validateForm() {
    if (!_emailController.text.contains("@")) {
      _showToast("Địa chỉ Email không chính xác.");
    } else if (_passwordController.text.isEmpty) {
      _showToast("Mật Khẩu Đăng Nhập Là Cần Thiết.");
    } else {
      _loginUser();
    }
  }

  // Display toast message
  void _showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  // Login user
  Future<void> _loginUser() async {
    if (!mounted) return;

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ProgressDialog(message: "Đang Xử Lý, Vui Lòng Chờ...");
      },
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        DatabaseReference messyHouseRef = FirebaseDatabase.instance.ref().child("messyHouse");
        final snapshot = await messyHouseRef.child(firebaseUser.uid).get();

        if (!mounted) return;
        Navigator.pop(context); // Close the dialog

        if (snapshot.exists) {
          currentFirebaseUser = firebaseUser;
          _showToast("Đăng Nhập Thành Công");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        } else {
          _showToast("Tài khoản không có quyền truy cập. Vui lòng liên hệ quản trị viên.");
          await firebaseAuthAuth.signOut();
        }
      } else {
        if (!mounted) return;
        Navigator.pop(context); // Close the dialog
        _showToast("Đã Xảy Ra Lỗi Khi Đăng Nhập.");
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close the dialog
      switch (e.code) {
        case 'user-not-found':
          _showToast("Không tìm thấy tài khoản với email này.");
          break;
        case 'wrong-password':
          _showToast("Sai mật khẩu. Vui lòng thử lại.");
          break;
        case 'invalid-email':
          _showToast("Địa chỉ email không hợp lệ.");
          break;
        case 'user-disabled':
          _showToast("Tài khoản này đã bị vô hiệu hóa.");
          break;
        default:
          _showToast("Lỗi đăng nhập: ${e.message}");
      }
    } catch (error) {
      if (!mounted) return;
      Navigator.pop(context); // Close the dialog
      _showToast("Lỗi không xác định: $error");
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
              const SizedBox(height: 40),
              Image.asset('images/logo.png', height: 120),
              const SizedBox(height: 30),
              const Text(
                'Đăng Nhập Khách Hàng Homer',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Nhập địa chỉ email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                label: 'Mật Khẩu',
                hint: 'Nhập mật khẩu',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Đăng Nhập",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const SignUpScreen()));
                },
                child: const Text(
                  'Chưa có tài khoản? Đăng ký tại đây',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}