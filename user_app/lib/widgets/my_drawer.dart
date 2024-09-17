
import 'package:flutter/material.dart';
import 'dart:io';
import '../global/global.dart';
import '../splashScreen/splash_screen.dart';

class MyDrawer extends StatelessWidget {
  final String? name;
  final String? email;
  final String? avatar;

  const MyDrawer({
    super.key,
    this.name,
    this.email,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                name ?? "User Name",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                email ?? "user@example.com",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: _getAvatarProvider(),
                child: _getAvatarProvider() == null
                    ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                )
                    : null,
              ),
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            _buildDrawerItem(
              icon: Icons.history,
              title: "History",
              onTap: () {
                // TODO: Implement history functionality
              },
            ),
            _buildDrawerItem(
              icon: Icons.person,
              title: "Visit Profile",
              onTap: () {
                // TODO: Implement visit profile functionality
              },
            ),
            _buildDrawerItem(
              icon: Icons.info,
              title: "About",
              onTap: () {
                // TODO: Implement about functionality
              },
            ),
            const Divider(color: Colors.white24),
            _buildDrawerItem(
              icon: Icons.logout,
              title: "Sign Out",
              onTap: () {
                fAuth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _getAvatarProvider() {
    if (avatar == null || avatar!.isEmpty) return null;
    if (avatar!.startsWith('http://') || avatar!.startsWith('https://')) {
      return NetworkImage(avatar!);
    } else {
      try {
        return FileImage(File(Uri.parse(avatar!).toFilePath()));
      } catch (e) {
        // if (kDebugMode) {
        //   print('Error loading avatar: $e');
        // }
        return null;
      }
    }
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
      onTap: onTap,
      hoverColor: Colors.white10,
    );
  }
}