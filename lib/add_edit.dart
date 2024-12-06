import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/get_all.dart';
import 'package:todo_dummy/initail_design.dart';
import 'package:todo_dummy/model/todo_model.dart';

class AddEdit extends StatefulWidget {
  final String? option;
  const AddEdit({super.key, this.option});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  bool _validate = false;
  TextEditingController taskController = TextEditingController();

  Future<TodoModel?> fetchCreateData() async {
    TodoModel? result;
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('https://dummyjson.com/todos/add'));
    request.body = json
        .encode({"todo": taskController.text, "completed": false, "userId": 5});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      result = TodoModel.fromJson(jsonResponse);
    } else {
      print('Failed to add todo. Status code: ${response.statusCode}');
    }
    return result;
  }

  Future<void> OnCreateToDo() async {
    TodoModel? create = await fetchCreateData();
    Navigator.pop(context);
    if (create != null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Create Successed'),
                content: Text('${create?.todo} was created!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GetAll()));
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                    color: Colors.lightBlueAccent,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.option ?? "Add To Do",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 35,
                              color: Colors.white,
                            ))
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: TextField(
                          controller: taskController,
                          decoration: InputDecoration(
                              errorText:
                                  _validate ? "Value Can't Be Empty" : null,
                              errorStyle: TextStyle(color: Colors.red),
                              border: OutlineInputBorder(),
                              hintText: "Add To Do"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          if (taskController.text.isEmpty) {
                            _validate = taskController.text.isEmpty;
                          } else {
                            OnCreateToDo();
                          }
                        },
                        child: Text("Save"),
                        //style: MinColumnWidth(100, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
