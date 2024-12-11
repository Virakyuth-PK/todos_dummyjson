import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/model/limit_skip_model.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';
import 'package:todo_dummy/update.dart';

class LimitSkip extends StatefulWidget {
  @override
  State<LimitSkip> createState() => _LimitSkipState();
}

class _LimitSkipState extends State<LimitSkip> {
  bool validateSkip = false;
  bool validateLimit = false;
  TextEditingController limitController = TextEditingController();
  TextEditingController skipController = TextEditingController();
  late TextEditingController updateController;
  bool isSeleted = false;
  LimitSkipModel? toDoSkip;

  List<TodoModel> todos = [];

  @override
  void initState() {
    super.initState();
    updateController = TextEditingController();
  }

  Future<void> limitSkip() async {
    var request = http.Request(
      'GET',
      Uri.parse(
          'https://dummyjson.com/todos?limit=${limitController.text}&skip=${skipController.text}'),
    );

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody); // Print the response body once
        var jsonResponse = json.decode(responseBody);
        setState(() {
          toDoSkip = LimitSkipModel.fromJson(jsonResponse);
        });
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error during request: $e');
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

  void showButtomSheet(int id, int index) {
    isSeleted = (toDoSkip?.todos ?? [])[index].completed;
    updateController.text = (toDoSkip?.todos ?? [])[index].todo ?? "";

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
          foregroundColor: Colors.white,
          title: Text(
            "Limit and Skip ToDo",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.lightBlueAccent[100],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: skipController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            validateSkip = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Input Skip",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        errorText: validateSkip ? "Value Can't Be Empty" : null,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: limitController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            validateLimit = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        hintText: "Input Limit",
                        errorText:
                            validateLimit ? "Value Can't Be Empty" : null,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      // child: GestureDetector(
                      //   onTap: () {
                      //     limitSkip();
                      //   },
                      //   child: Container(
                      //     child: Text("Press"),
                      //   ),
                      // ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (limitController.text.isNotEmpty &&
                                skipController.text.isNotEmpty) {
                              limitSkip();
                            } else {
                              if (limitController.text.isEmpty) {
                                validateLimit = limitController.text.isEmpty;
                              }
                              if (skipController.text.isEmpty) {
                                validateSkip = skipController.text.isEmpty;
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.lightBlueAccent,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "Skip:${toDoSkip?.skip}",
                      ),
                      // Text(skip?.toDo'' ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Text("Limit:${toDoSkip?.limit}"),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Text("Total:${toDoSkip?.total}"),
                    ],
                  )),
                ],
              ),
            ),
            if (toDoSkip == null) ...[
              Container(
                padding: EdgeInsets.all(50),
                child: Text(
                  "No Data",
                  textAlign: TextAlign.center,
                ),
              )
            ] else ...[
              Expanded(
                child: ListView.builder(
                    itemCount: (toDoSkip?.todos ?? []).length,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var item = toDoSkip?.todos![index];

                      return TodoTask(
                        todo: item?.todo,
                        value: item?.completed,
                        onDelete: () {
                          onDeletedToDo(item?.id ?? 0);
                        },
                        onUpdate: () {
                          showButtomSheet(item?.id ?? 0, index);
                        },
                        onPressed: () {
                          detailScreen(
                              item?.todo ?? "", item?.completed ?? false);
                        },
                        onChanged: (bool? value) {
                          setState(() {
                            item?.completed = value ?? false;
                            updateStatus(
                                isComplete: item?.completed, id: item?.id);
                            print("value $value");
                            print("completed ${item?.completed}");
                          });
                        },
                      );
                    }),
              ),
            ]
          ],
        ));
  }
}
