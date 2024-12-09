import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/model/limit_skip_model.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';

class LimitSkip extends StatefulWidget {
  @override
  State<LimitSkip> createState() => _LimitSkipState();
}

class _LimitSkipState extends State<LimitSkip> {
  bool _validate = false;
  TextEditingController limitController = TextEditingController();
  TextEditingController skipController = TextEditingController();

  LimitSkipModel? toDoSkip;

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
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: skipController,
                      decoration: InputDecoration(
                        hintText: "Input Skip",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        errorText: _validate ? "Value Can't Be Empty" : null,
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        hintText: "Input Limit",
                        errorText: _validate ? "Value Can't Be Empty" : null,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        limitSkip();
                      },
                      child: Container(
                        child: Text("Press"),
                      ),
                    ),
                    // child: ElevatedButton(
                    //   onPressed: () => limitSkip,
                    //   // onPressed: () {
                    //   //   setState(() {
                    //   //     if (limitController.text.isEmpty) {
                    //   //       _validate = limitController.text.isEmpty;
                    //   //     } else if (skipController.text.isEmpty) {
                    //   //       _validate = skipController.text.isEmpty;
                    //   //     } else {
                    //   //       ;
                    //   //     }
                    //   //   });
                    //   // },
                    //   child: Icon(
                    //     Icons.search,
                    //     color: Colors.lightBlueAccent,
                    //   ),
                    // )),
                  )
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
                        "Skip",
                      ),
                      // Text(skip?.toDo'' ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Text("Limit,${toDoSkip?.limit}"),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Text("Total"),
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
              ListView.builder(
                  itemCount: (toDoSkip?.todos ?? []).length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = toDoSkip?.todos![index];
                    return TodoTask(
                      todo: item?.todo,
                      value: item?.completed,
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
            ]
          ],
        ));
  }
}
