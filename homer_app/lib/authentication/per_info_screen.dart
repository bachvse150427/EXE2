import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart" show ImagePicker, ImageSource, XFile;
import 'dart:io';

class PerInfoScreen extends StatefulWidget {
  const PerInfoScreen({super.key});



  @override
  State<PerInfoScreen> createState() => _PerInfoScreenState();
}

class _PerInfoScreenState extends State<PerInfoScreen> {
  TextEditingController informationsTextEditingController = TextEditingController();
  List<String> perTypesList = ["Làm Sạch Nhà",]; // Công nghiệp
  String? selectedPerType;
  File? _image; // Holds the image file

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

<<<<<<< HEAD
  // Function to save personal info
  savePerInfo() {
    Map housekeeperInfoMap = {
      "per_info": informationsTextEditingController.text.trim(),
      "per_avatar": _image!.path,  // Store the image path
      "type": selectedPerType,  // Store the selected service type
    };


    DatabaseReference housekeeperRef = FirebaseDatabase.instance.ref().child("housekeeper");
    housekeeperRef.child(currentFirebaseUser!.uid).child("housekeeper_details").set(housekeeperInfoMap);

    Fluttertoast.showToast(msg: "Thông Tin Về Bạn Đã Lưu.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }


=======
>>>>>>> parent of bdb1abb (1. fix fontend, and push regit data to firebase but not had reeltime database reup)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 27,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("images/logo1.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Thông Tin Đối Tác.',
              style: TextStyle(
                fontSize: 27,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: informationsTextEditingController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Giới Thiệu Thông Tin',
                hintText: 'Giới Thiệu Thông Tin',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintStyle: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 11,
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            DropdownButton(
              iconSize: 26,
              dropdownColor: Colors.blue,
              hint: const Text(
                "Chọn Một Loại Dịch Vụ",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.orange,
                ),
              ),
              value: selectedPerType,
              onChanged: (newValue) {
                setState(() {
                  selectedPerType = newValue.toString();
                });
              },
              items: perTypesList.map((car) {
                return DropdownMenuItem(
                  value: car,
                  child: Text(
                    car,
                    style: const TextStyle(color: Colors.orange),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),

            // Image Display Section
            _image == null
                ? const Text(
              'Chưa Có Ảnh Được Chọn',
              style: TextStyle(color: Colors.red),
            )
                : Image.file(_image!, height: 200, width: 200),

            const SizedBox(height: 20,),

            // Button to capture image from camera
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: const Text(
                'Chụp Ảnh',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => PerInfoScreen()));
                // Save info logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              child: const Text(
                'Lưu Thông Tin',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
