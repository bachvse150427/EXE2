import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homer_app/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Firebase initialization for web with FirebaseOptions
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDY6B4kmNV4sJaso_kmlSUMGzaqpXOiJvI",
        authDomain: "homer-housekeeper-app-3a60b.firebaseapp.com",
        projectId: "homer-housekeeper-app-3a60b",
        storageBucket: "homer-housekeeper-app-3a60b.appspot.com",
        messagingSenderId: "688168394540",
        appId: "1:688168394540:web:ec92a874646324c36b1689",
      ),
    );
  } else {
    // Firebase initialization for non-web (iOS, Android)
    await Firebase.initializeApp();
  }

  runApp(MyApp(
    child: MaterialApp(
      title: 'Homer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  final Widget? child;

  const MyApp({super.key, this.child});

  // Function to restart the app
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  // Function to restart the app by generating a new key
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}
