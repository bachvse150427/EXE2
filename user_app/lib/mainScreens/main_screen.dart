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
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position? currentPosition;
  var geoLocator = Geolocator();

  final GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

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
      key: sKey,
      drawer: MyDrawer(
        name: userModelCurrentInfo?.name,
        email: userModelCurrentInfo?.email,
      ),
      body: Stack(
        children: [
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
          //custom hamburger button for drawer
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
        ],
      ),
    );
  }
}