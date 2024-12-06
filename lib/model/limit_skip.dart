import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';

class LimitSkip extends StatefulWidget {
  LimitSkip({super.key});

  @override
  State<LimitSkip> createState() => _LimitSkipState();
}

class _LimitSkipState extends State<LimitSkip> {
  List<TodoModel> toDo = [];
  @override
  void initState() {
    super.initState();
    getById();
  }

  Future<void> getById() async {
    // var request = http.Request(
    //     'GET', Uri.parse('https://dummyjson.com/todos?limit=3&skip=10'));
    final response = await http
        .get(Uri.parse('https://dummyjson.com/todos?limit=3&skip=10'));
    // http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> todosList = jsonData['todos'];
      setState(() {
        toDo = todosList.map((data) => TodoModel.fromJson(data)).toList();
      });
    } else {
      print(response.reasonPhrase);
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

  void detailScreen(String todo, bool completed) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScreenDetail(
        todo: todo,
        status: completed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            "Limit and Skip ToDo",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                        decoration: InputDecoration(hintText: "Input Skip")),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Input Limit",
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {}, child: Icon(Icons.search))),
                ],
              ),
            ),
            ListView.builder(
                itemCount: toDo.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TodoTask(
                    todo: toDo[index].todo,
                    value: toDo[index].completed,
                    onPressed: () {
                      detailScreen(
                          toDo[index].todo ?? "", toDo[index].completed);
                    },
                    onChanged: (bool? value) {
                      setState(() {
                        toDo[index].completed = value ?? false;
                        updateStatus(
                            isComplete: toDo[index].completed,
                            id: toDo[index].id);
                        print("value $value");
                        print("completed ${toDo[index].completed}");
                      });
                    },
                  );
                }),
          ],
        ));
  }
}
