import 'package:duvit/screens/info_screen.dart';
import 'package:duvit/screens/map_screen.dart';
import 'package:duvit/shared_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Instance the shared preferences
  final prefs = new PreferenciasUsuario();

  int currentIndex = 0;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        key: globalKey,
        drawer: _crearDrawer(),
        drawerEnableOpenDragGesture: false,
        body: _callPage(currentIndex),
        bottomNavigationBar: _crearBottomNavigationBar( context ),
        floatingActionButton: _crearFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _crearBottomNavigationBar( BuildContext context ) {
    return BottomAppBar( //bottom navigation bar on scaffold
      shape: CircularNotchedRectangle(), //shape of notch
      notchMargin: 6, //notche margin between floating button and bottom appbar
      child: Container(
        height: 56,
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {
              
              //return Scaffold.of(context).openDrawer();
              return globalKey.currentState!.openDrawer();
      
            },),
            IconButton(icon: Icon(Icons.add_location_alt), onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.notifications), onPressed: () {
              setState(() {
                currentIndex = 2;
              });
            },),
            IconButton(icon: Icon(Icons.settings), onPressed: () {
              setState(() {
                currentIndex = 3;
              });
            },),
          ],
        ),
      ),
    );
    /*return BottomNavigationBar(
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work), 
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_turned_in), 
          label: 'Asistencia'
        )
      ],
    );*/
  }

  Widget _crearFloatingButton() {
    return FloatingActionButton(
        elevation: 8.0,
        child: new Icon(Icons.task),
        onPressed: (){}
      );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapScreen();
      case 1:
        return MapScreen();
      case 2:
        return InfoScreen();
      case 3:
        return InfoScreen();

      default:
        return MapScreen();
    }
  }

  Widget _crearDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50.0,
              ),
            ),
            accountName: Text( prefs.name ),
            accountEmail: Text( prefs.email.isNotEmpty ? prefs.email : 'Sin correo corporativo' ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Profile Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.cached,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Recenceter"),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Acerca de nosotros"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Configuración"),
            onTap: () {},
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Cerrar sesión"),
            onTap: () {
              prefs.clear();
              Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'));
            },
          ),
        ],
      ),
    );
  }

  
}
