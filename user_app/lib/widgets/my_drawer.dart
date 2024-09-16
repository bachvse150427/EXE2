import 'package:flutter/material.dart';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';

class MyDrawer extends StatefulWidget {
  final String? name;
  final String? email;

  const MyDrawer({Key? key, this.name, this.email}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
    // print("MyDrawer initialized with name: ${widget.name}, email: ${widget.email}");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87, // Set a dark background for the drawer
        child: ListView(
          children: [
            //drawer header
            Container(
              height: 165,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name ?? "Tên Không Tồn Tại",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.email ?? "Email Không Tồn tại",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12.0),

            //drawer body
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white),
              title: const Text(
                "Lịch Sử",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle History tap
              },
            ),

            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                "Thông tin Cá Nhân",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle Visit Profile tap
              },
            ),

            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text(
                "Thông Tin",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle About tap
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                "Đăng Xuất",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                firebaseAuthAuth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}