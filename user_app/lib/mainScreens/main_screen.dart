import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';
import '../widgets/my_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  Position? currentPosition;
  var geoLocator = Geolocator();

  // Global key for the scaffold state
  final GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  // Search container height
  double searchLocationContainerHeight = 350;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    await AssistantMethods.readCurrentOnlineUserInfo();
    setState(() {});
  }

  Future<void> locatePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Show dialog for denied permission
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show dialog for permanently denied permission
      return;
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,  // Scaffold key
      drawer: MyDrawer(
        name: userModelCurrentInfo?.name,
        email: userModelCurrentInfo?.email,
      ),
      body: Stack(
        children: [
          // Google map widget
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locatePosition();
            },
          ),
          // Custom hamburger button for drawer
          Positioned(
            top: 30,
            left: 20,
            child: GestureDetector(
              onTap: () {
                sKey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.menu,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          // Search location container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: searchLocationContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tìm Kiếm Vị Trí",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Darker color for better readability
                      ),
                    ),
                    const SizedBox(height: 20), // Reduced space for tighter layout
                    GestureDetector(
                      onTap: () {
                        // Logic for opening search box
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[100], // Lighter background for better contrast
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[400]!, width: 1), // Add subtle border for a refined look
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add_location, color: Colors.grey[600]), // Slightly darker icon
                            const SizedBox(width: 12),
                            const Text(
                              "Nhập Vị Trí Công Việc Sẽ Làm",
                              style: TextStyle(color: Colors.black54), // Lighter text color
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15), // Adjusted spacing between elements
                    GestureDetector(
                      onTap: () {
                        // Logic for opening search box
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[400]!, width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add_location, color: Colors.grey[600]),
                            const SizedBox(width: 12),
                            const Text(
                              "Vị Trí Hai Bên Gặp Nhau",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Space between the text fields and the button
                    SizedBox(
                      width: double.infinity, // Make the button take full width
                      child: ElevatedButton(
                        onPressed: () {
                          // Logic for searching a supporter
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12), // Increase button height
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2, // Slight shadow for depth
                        ),
                        child: const Text(
                          "Tìm Một Người Hỗ Trợ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color for contrast on the green background
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
