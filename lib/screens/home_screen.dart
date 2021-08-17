import 'package:duvit/screens/info_screen.dart';
import 'package:duvit/screens/map_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      notchMargin: 8, //notche margin between floating button and bottom appbar
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
            IconButton(icon: Icon(Icons.verified_user), onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.notifications), onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },),
            IconButton(icon: Icon(Icons.settings), onPressed: () {
              setState(() {
                currentIndex = 1;
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
      case 1:
        return MapScreen();
      case 0:
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
            accountName: Text('User Name'),
            accountEmail: Text('examlpe@gmail.com'),
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
                Icons.settings,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Settings"),
            onTap: () {},
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
            title: Text("About us"),
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
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  
}
