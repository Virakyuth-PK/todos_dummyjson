import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/card_widget.dart';
import 'package:todo_dummy/get_all.dart';
import 'package:todo_dummy/limit_skip.dart';
import 'package:todo_dummy/get_by_id.dart';
import 'package:todo_dummy/random.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

///Home Screen
class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///title of home screen
        title: const Text("To Do List",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.blue,
      ),

      ///Have 3 Row
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ///Row 1
            ///Button Get All ToDos
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: CardWidget(
                    svg:
                        'https://www.svgrepo.com/show/532816/folder-arrow-up.svg',
                    title: "Get all TODOs",
                    color: Colors.lightBlueAccent[100],
                    onPressed: () {
                      //Route To 2nd Screen {Get all Screen}
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => GetAll()));
                    },
                  ),
                ),
              ],
            )),

            const SizedBox(
              height: 15,
            ),

            ///Row 2
            Expanded(
              child: Row(
                children: [
                  ///Button Get Single To Do
                  Expanded(
                      child: CardWidget(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetByUserId()));
                          },
                          svg:
                              'https://www.svgrepo.com/show/532387/user-search.svg',
                          title: "Get ToDos by User ID",
                          color: Colors.greenAccent[100])),
                  const SizedBox(
                    width: 15,
                  ),

                  ///Button Random To Do
                  Expanded(
                      child: CardWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RandomToDo()));
                    },
                    svg: 'https://www.svgrepo.com/show/391659/random.svg',
                    title: "Get a random ToDos",
                    color: Colors.greenAccent[100],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            ///Row3
            Expanded(
              child: Row(
                children: [
                  ///Button Limit And Skip
                  Expanded(
                      child: CardWidget(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LimitSkip()));
                    },
                    svg: 'https://www.svgrepo.com/show/471906/skip-forward.svg',
                    title: "Limit & Skip ToDos",
                    color: Colors.limeAccent[100],
                  )),
                  SizedBox(
                    width: 15,
                  ),

                  ///Button Add To Do
                  Expanded(
                      child: CardWidget(
                    onPressed: () {
                      ///show bottom sheet of Add To Do
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => AddEdit(),
                      );
                    },
                    svg: 'https://www.svgrepo.com/show/510788/add-to-queue.svg',
                    title: "Add a ToDos",
                    color: Colors.limeAccent[100],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
