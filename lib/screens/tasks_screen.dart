import 'package:duvit/models/task_model.dart';
import 'package:duvit/providers/tasks_provider.dart';
import 'package:duvit/shared_prefs/user_preferences.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final tasksProvider = new TasksProvider();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Tareas', style: TextStyle(color: Colors.black)),
          elevation: 2.0,
          backgroundColor: Colors.white),
      body: FutureBuilder(
          future: tasksProvider.getTasks(prefs.idStaff),
          builder:
              (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
            if (snapshot.hasData) {
              final tasks = snapshot.data;

              if (tasks!.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: ListView.builder(
                    itemCount: tasks!.length,
                    itemBuilder: (context, index) =>
                        _crearItem(context, tasks[index], index),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.done, size: 40.0),
                        SizedBox(height: 8.0),
                        Text('No cuenta con tareas pendientes'),
                      ],
                    ),
                  ],
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _crearItem(BuildContext context, TaskModel task, int index) {
    index = index + 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTileCard(
        /*key: cardA,*/
        leading: CircleAvatar(child: Text("T0" + index.toString())),
        title:
            Text(task.proyecto, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Act. " + task.actividad + "\nTarea:" + task.tarea),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Detalle: " + task.detalle,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Fecha inicio: " +
                    task.fechaInicio +
                    "\nFecha fin: " +
                    task.fechaFin +
                    "\nFecha límite: " +
                    task.fechaLimite,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                style: flatButtonStyle,
                //onPressed: task.idProyecto != 1 ? null : () {
                onPressed: () {
                  final response =
                      tasksProvider.checkTask(task.idPlaneacion, 0);
                  response.then((value) async {
                    if (value) {
                      showMessage("Se ha registrado el inicio de la tarea");
                    } else {
                      showMessage(
                          "Hemos tenido un problema al registrar el inicio");
                    }

                    //await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  });
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.play_arrow_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Iniciar'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  final response =
                      tasksProvider.checkTask(task.idPlaneacion, 1);
                  response.then((value) async {
                    if (value) {
                      showMessage("Se ha registrado la pausa de la tarea");
                    } else {
                      showMessage(
                          "Hemos tenido un problema al registrar la pausa");
                    }

                    //await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  });
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.pause_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Pausar'),
                  ],
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  final response =
                      tasksProvider.checkTask(task.idPlaneacion, 2);
                  response.then((value) async {
                    if (value) {
                      showMessage(
                          "Se ha registrado la finalización de la tarea");
                    } else {
                      showMessage(
                          "Hemos tenido un problema al registrar la finalización");
                    }

                    //await Future.delayed(Duration(seconds: 3));
                    setState(() {});
                  });
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.stop_rounded),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Finalizar'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void start() async {}

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
