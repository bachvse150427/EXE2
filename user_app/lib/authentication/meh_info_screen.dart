import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource, XFile;
import 'dart:io';
import 'package:user_app/global/global.dart';
import 'package:user_app/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart' show DatabaseReference, FirebaseDatabase;
import "package:fluttertoast/fluttertoast.dart" show Fluttertoast;


class MehInfoScreen extends StatefulWidget {
  const MehInfoScreen({super.key});

  @override
  State<MehInfoScreen> createState() => _MehInfoScreenState();
}

class _MehInfoScreenState extends State<MehInfoScreen> {
  TextEditingController informationsTextEditingController = TextEditingController();// Service types
  File? _image; // Holds the image file

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the camera
  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  // Function to save personal info
  savePerInfo() {
    Map messyHouseInfoMap = {
      "meh_info": informationsTextEditingController.text.trim(),
      "meh_avatar": _image!.path,  // Store the image path
    };


    DatabaseReference messyHouseRef = FirebaseDatabase.instance.ref().child("messyHouse");
    messyHouseRef.child(currentFirebaseUser!.uid).child("messyHouse_details").set(messyHouseInfoMap);


    Fluttertoast.showToast(msg: "Thông Tin Về Bạn Đã Lưu.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // Lighter blue background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Image.asset("images/logo.png", height: 120),
            const SizedBox(height: 20),
            const Text(
              'Thông Tin Khách Hàng',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: informationsTextEditingController,
              style: const TextStyle(color: Colors.black87),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Giới Thiệu Thông Tin',
                hintText: 'Giới Thiệu Về Bạn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            _image == null
                ? Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Quý Khách Chụp Ảnh Cá Nhân Hoặc Chọn Ảnh Bất Kỳ ',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImageFromCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Chụp Ảnh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (informationsTextEditingController.text.isNotEmpty &&
                    _image != null) {
                  savePerInfo();
                } else {
                  Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin.");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Lưu Thông Tin',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}