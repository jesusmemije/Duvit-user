import 'package:duvit/models/project_model.dart';
import 'package:duvit/providers/projects_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

class ProjectMembersScreen extends StatelessWidget {

  final projectsProvider = new ProjectsProvider();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    final projectListModel = ModalRoute.of(context)!.settings.arguments as ProjectListModel;

    return Scaffold(
      appBar: _crearAppBar( context, projectListModel.nombreProyecto),
      body:  _crearListado(),
    );
  }

  PreferredSize _crearAppBar( BuildContext context, String nombreProyecto ) {

    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text( 'Miembros', style: TextStyle(color: Colors.black)),
            Text( 'Proyecto • $nombreProyecto', style:  TextStyle( fontWeight : FontWeight.w400, fontSize : 12, letterSpacing : 0.2, color : Color(0xFF4A6572) )),
          ],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            color: Colors.black87,
            icon: Icon(
              Icons.close,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

  }

  _crearListado() {}

}