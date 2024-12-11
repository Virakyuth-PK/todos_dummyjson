import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/update.dart';

class GetAll extends StatefulWidget {
  const GetAll({super.key});

  @override
  State<GetAll> createState() => _GetAllState();
}

class _GetAllState extends State<GetAll> {
  List<TodoModel> todos = [];
  late TextEditingController updateController;
  bool isSeleted = false;
  @override
  void initState() {
    super.initState();
    updateController = TextEditingController();
    fetchToDo();
  }

  Future<void> fetchToDo() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/todos'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> todosList = jsonData['todos'];
      setState(() {
        todos = todosList.map((data) => TodoModel.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
      print("Error data fetch");
    }
  }

  Future<void> updateStatus({int? id, bool? isComplete}) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse('https://dummyjson.com/todos/$id'));
    request.body = json.encode({"completed": isComplete});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  ///show button sheet of Detail Screen about To Do
  void detailScreen(String todo, bool completed) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScreenDetail(
        todo: todo,
        status: completed,
      ),
    );
  }

  Future<TodoModel?> deleteFetchData(int id) async {
    TodoModel? result;
    var request =
        http.Request('DELETE', Uri.parse('https://dummyjson.com/todos/${id}'));
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseBody);
      setState(() {
        result = TodoModel.fromJson(jsonResponse);
      });
    } else {
      print('Failed to add todo. Status code: ${response.statusCode}');
    }
    return result;
  }

  Future<void> onDeletedToDo(int id) async {
    TodoModel? delete = await deleteFetchData(id);

    if (delete != null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Deleted Successed'),
                content: Text('${delete.todo} was deleted!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('close'),
                  ),
                ],
              ));
    }
  }

  Future<TodoModel?> fetchUpdateData(int id) async {
    TodoModel? result;
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse('https://dummyjson.com/todos/${id}'));
    request.body =
        json.encode({"todo": updateController.text, "completed": isSeleted});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseBody);
      result = TodoModel.fromJson(jsonResponse);
    } else {
      print('Failed to add todo. Status code: ${response.statusCode}');
    }
    return result;
  }

  Future<void> onUpdateToDo(int id) async {
    TodoModel? update = await fetchUpdateData(id);

    if (update != null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Update Successed'),
                content: Text('${update.todo} was Updated!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Close'),
                    child: const Text('Close'),
                  ),
                ],
              ));
    }
  }

  void showButtomSheet(int id, int index) {
    isSeleted = todos[index].completed;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 500,
              child: Update(
                updateController: updateController,
                value: isSeleted,
                onSave: () {
                  onUpdateToDo(id);
                },
                onChanged: (value) {
                  setState(
                    () {
                      isSeleted = value ?? false;
                    },
                  );
                },
              ),
            );
          });
        });
  }

  /// Screen get all To Do ,2nd Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Get All ToDos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.lightBlueAccent[100],
        foregroundColor: Colors.white,
      ),
      body: todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  todos.clear();
                });
                await fetchToDo();
              },
              child: ListView.builder(
                itemCount: todos.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  //return  Text("${todos.length}");
                  updateController.text = todos[index].todo ?? "";

                  return TodoTask(
                    todo: todos[index].todo,
                    value: todos[index].completed,
                    onDelete: () {
                      onDeletedToDo(todos[index].id ?? 0);
                    },
                    onUpdate: () {
                      showButtomSheet(todos[index].id ?? 0, index);
                    },
                    onPressed: () {
                      detailScreen(
                          todos[index].todo ?? "", todos[index].completed);
                    },
                    onChanged: (bool? value) {
                      setState(() {
                        todos[index].completed = value ?? false;
                        updateStatus(
                            isComplete: todos[index].completed,
                            id: todos[index].id);
                        print("value $value");
                        print("completed ${todos[index].completed}");
                      });
                    },
                  );
                },
              ),
            ),

      /// Float Button Add To Do
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///show buttom sheet of Add
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddEdit(),
          );
        },
        backgroundColor: Colors.lightBlueAccent[100],
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
