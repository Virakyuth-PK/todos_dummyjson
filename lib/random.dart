import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/model/todo_model.dart';
import 'package:todo_dummy/random_widget.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';
import 'package:todo_dummy/update.dart';

class RandomToDo extends StatefulWidget {
  const RandomToDo({
    super.key,
  });

  @override
  State<RandomToDo> createState() => __RandomToDoState();
}

class __RandomToDoState extends State<RandomToDo> {
  List<TodoModel> todos = [];

  TodoModel? result;

  @override
  void initState() {
    super.initState();

    fetchRandom();
  }

  Future<TodoModel?> fetchRandom() async {
    var request =
        http.Request('GET', Uri.parse('https://dummyjson.com/todos/random'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      setState(() {
        result = TodoModel.fromJson(jsonResponse);
      });
    } else {
      // Handle error if needed
      print("Error data fetch");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Get Random ToDo",
            style: TextStyle(fontWeight: FontWeight.w500)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => RandomToDo()),
                          (Route<dynamic> route) => false,
                        );
                        fetchRandom();
                      });
                    },
                    child: Text("Random"))),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: RandomWidget(
                          title: "ID",
                          value: "${result?.id}",
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: RandomWidget(
                        title: "ToDo",
                        value: "${result?.todo}",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: RandomWidget(
                          title: "Completed",
                          value: "${result?.completed}",
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: RandomWidget(
                          title: "UserId",
                          value: "${result?.userId}",
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
