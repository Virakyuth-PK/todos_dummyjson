import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_dummy/initail_design.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/update.dart';

class GetByUserId extends StatefulWidget {
  const GetByUserId({super.key});

  @override
  State<GetByUserId> createState() => _GetByUserIdState();
}

class _GetByUserIdState extends State<GetByUserId> {
  List<TodoModel> todoId = [];
  bool validateUser = false;
  TextEditingController userController = TextEditingController();
  late TextEditingController updateController;
  bool isSeleted = false;
  TodoModel? toDo;
  @override
  void initState() {
    super.initState();
    updateController = TextEditingController();
    fetchToDoByUser();
  }

  Future<void> fetchToDoByUser() async {
    final response = await http.get(
        Uri.parse('https://dummyjson.com/todos/user/${userController.text}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> todosList = jsonData['todos'];
      setState(() {
        todoId = todosList.map((data) => TodoModel.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
      print("Error data fetch");
    }
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

  void showButtomSheet(int id, int index) {
    isSeleted = todoId[index].completed;
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
        title: Text("Get ToDos By User ID",
            style: TextStyle(fontWeight: FontWeight.w500)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: userController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            validateUser = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        hintText: "Input User ID (int)",
                        errorText: validateUser ? "Value Can't Be Empty" : null,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fetchToDoByUser();
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (toDo == null) ...[
          //   Container(
          //     padding: EdgeInsets.symmetric(vertical: 200),
          //     child: Text(
          //       "No Data",
          //       textAlign: TextAlign.center,
          //     ),
          //   )
          // ] else ...[
          Expanded(
            child: ListView.builder(
                itemCount: todoId.length,
                itemBuilder: (BuildContext context, int index) {
                  updateController.text = todoId[index].todo ?? "";

                  return TodoTask(
                    todo: todoId[index].todo,
                    value: todoId[index].completed,
                    onDelete: () {
                      onDeletedToDo(todoId[index].id ?? 0);
                    },
                    onUpdate: () {
                      showButtomSheet(todoId[index].id ?? 0, index);
                    },
                    onPressed: () {
                      detailScreen(
                          todoId[index].todo ?? "", todoId[index].completed);
                    },
                    onChanged: (bool? value) {
                      setState(() {
                        todoId[index].completed = value ?? false;
                        updateStatus(
                            isComplete: todoId[index].completed,
                            id: todoId[index].id);
                        print("value $value");
                        print("completed ${todoId[index].completed}");
                      });
                    },
                  );
                }),
          )
          // ]
        ],
      ),
    );
  }
}
