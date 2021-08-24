import 'package:duvit/screens/tasks_history_screen.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:duvit/screens/screens.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(DuvitApp());

}

class DuvitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    var logeado = prefs.logeado;

    return MaterialApp(
      initialRoute: logeado == false ? '/login' : '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home'          : ( _ ) => HomeScreen(),
        '/login'         : ( _ ) => LoginScreen(),
        '/map'           : ( _ ) => MapScreen(),
        '/tasks'         : ( _ ) => TasksScreen(),
        '/tasks_history' : ( _ ) => TasksHistoryScreen(),
        '/info'          : ( _ ) => InfoScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}
