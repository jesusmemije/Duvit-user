import 'dart:convert';
import 'package:duvit/models/task_model.dart';
import 'package:http/http.dart' as http;

class TasksProvider {

  final String _url = "http://www.duvitapp.com/WebService/v2";

  Future<List<TaskModel>> getTasks( int idStaff, String statusFollowUser) async {

    final url = '$_url/tasks.php?idStaff=$idStaff&status=$statusFollowUser';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<TaskModel> listTask = [];

    decodedData.forEach((id, task) {

      final taskTemp = TaskModel.fromJson(task);

      listTask.add( taskTemp );

    });

    return listTask;

  }

  Future<List<TaskModel>> getTasksEnd( int idStaff) async {

    final url = '$_url/tasks.php?idStaff=$idStaff&type=tasks_end';
    final resp = await http.get( Uri.parse(url) );

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<TaskModel> listTask = [];

    decodedData.forEach((id, task) {

      final taskTemp = TaskModel.fromJson(task);

      listTask.add( taskTemp );

    });

    return listTask;

  }

  Future<bool> checkTask( int idPlaneacion, int tipo) async {

    final url = '$_url/check-tasks.php?idPlaneacion=$idPlaneacion&tipo=$tipo';

    final response = await http.get( Uri.parse(url) );
    final decodedData = json.decode(response.body);

    print(decodedData);

    if ( decodedData['ok'] ) {
      return true;
    } else {
      return false;
    }

  } 

}