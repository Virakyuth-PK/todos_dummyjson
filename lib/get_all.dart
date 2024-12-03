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
  bool isGetUp = false;
  bool isWorkout = false;
  bool isMovie = false;
  bool isCamping = false;
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

  ///show button sheet of Detail Screen about To Do
  void detailScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScreenDetail(),
    );
  }

  /// Screen get all To Do ,2nd Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Get All ToDos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final task = todos[index];
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.lightBlueAccent.withOpacity(0.2),
            child: Column(
              children: [
                ///First Task
                ///
                Text("${todos.length}"),
                TodoTask(
                  todo: "${task}",
                  value: isGetUp,
                  color: Colors.cyanAccent,
                  onPressed: detailScreen,
                  onChanged: (bool? value) {
                    setState(() {
                      isGetUp = value ?? false;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),

                // ///2nd Task
                // TodoTask(
                //   todo: "WorkOut WorkOut WorkOut WorkOut WorkOut WorkOut",
                //   onPressed: detailScreen,
                //   value: isWorkout,
                //   color: Colors.limeAccent,
                //   onChanged: (bool? value) {
                //     setState(() {
                //       isWorkout = value ?? false;
                //     });
                //   },
                // ),
                // SizedBox(
                //   height: 15,
                // ),

                // ///3rd Task
                // TodoTask(
                //   todo: "Movie",
                //   value: isMovie,
                //   color: Colors.purpleAccent,
                //   onChanged: (bool? value) {
                //     setState(() {
                //       isMovie = value ?? false;
                //     });
                //   },
                // ),
                // SizedBox(
                //   height: 15,
                // ),

                // ///4th Task
                // TodoTask(
                // todo: "Camping with Friend ",
                // value: isCamping,
                // color: Colors.pink,
                // onChanged: (bool? value) {
                //   setState(() {
                //     isCamping = value ?? false;
                //   });
                // },
                // ),
              ],
            ),
          );
        },
      ),

      /// Float Button Add To Do
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///show buttom sheet of Add
          showModalBottomSheet(
            context: context,
            builder: (context) => AddEdit(),
          );
        },
        child: Icon(
          Icons.add,
          size: 25,
        ),
        backgroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
