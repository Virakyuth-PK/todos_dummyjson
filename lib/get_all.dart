import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';
import 'package:http/http.dart' as http;

class GetAll extends StatefulWidget {
  const GetAll({super.key});

  @override
  State<GetAll> createState() => _GetAllState();
}

class _GetAllState extends State<GetAll> {
  List<TodoModel> todos = [];
  @override
  void initState() {
    super.initState();
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
  void detailScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ScreenDetail(),
    );
  }

  /// Screen get all To Do ,2nd Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Get All ToDos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
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
                  return TodoTask(
                    todo: todos[index].todo,
                    value: todos[index].completed,
                    onPressed: detailScreen,
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
        backgroundColor: Colors.lightBlueAccent,
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
