import 'package:duvit/shared_prefs/preferencias_usuario.dart';
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
        '/home' : ( _ ) => HomeScreen(),
        '/login': ( _ ) => LoginScreen(),
        '/map'  : ( _ ) => MapScreen(),
        '/info' : ( _ ) => InfoScreen(),
      },
    );
  }
}
