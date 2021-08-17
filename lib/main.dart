import 'package:duvit/pages/home_page.dart';
import 'package:duvit/pages/info_page.dart';
import 'package:duvit/pages/login_page.dart';
import 'package:duvit/pages/map_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(DuvitApp());

class DuvitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/map': (context) => MapPage(),
        '/info': (context) => InfoPage(),
      },
    );
  }
}
