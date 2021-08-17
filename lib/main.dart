import 'package:flutter/material.dart';
import 'package:duvit/screens/screens.dart';

void main() => runApp(DuvitApp());

class DuvitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home' : ( _ ) => HomeScreen(),
        '/login': ( _ ) => LoginScreen(),
        '/map'  : ( _ ) => MapScreen(),
        '/info' : ( _ ) => InfoScreen(),
      },
    );
  }
}
