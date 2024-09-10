import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MyApp(
            child: MaterialApp(
                              title: 'Drivers App',
                              theme: ThemeData(
                              primarySwatch: Colors.blue,
                              ),
              home: Scaffold(
                              appBar: AppBar(
                                             title: Text('Chào mừng đến với Homer!'),
                                            ),
              body: Center(child: Text("HALOO")), // Add a body or child widget here
                            ),

              debugShowCheckedModeBanner: false,
                          ),
      ),
   );
}

class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
              {
                context.findAncestorStateOfType<_MyAppState>()!.restartApp();
              }
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();
  void restartApp()
  {
    setState((){
                  UniqueKey();
                }
              );
  }
  @override
  Widget build(BuildContext context){
    return KeyedSubtree(
                          key: key,
                          child: widget.child!,
                        );

  }
}