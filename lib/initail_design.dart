import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/card_widget.dart';
import 'package:todo_dummy/get_all.dart';
import 'package:todo_dummy/single_todo.dart';

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
        title: const Text("To Do List", style: TextStyle(color: Colors.white)),
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
                child: CardWidget(
              svg: 'https://pic.onlinewebfonts.com/thumbnails/icons_563230.svg',
              title: "Get all TODOs",
              color: Colors.lightBlueAccent,
              onPressed: () {
                //Route To 2nd Screen {Get all Screen}
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GetAll()));
              },
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
                                    builder: (context) => SingleTodo()));
                          },
                          svg:
                              'https://pic.onlinewebfonts.com/thumbnails/icons_427403.svg',
                          title: "Get a single ToDos",
                          color: Colors.cyanAccent)),
                  const SizedBox(
                    width: 15,
                  ),

                  ///Button Random To Do
                  const Expanded(
                      child: CardWidget(
                    svg:
                        'https://pic.onlinewebfonts.com/thumbnails/icons_436231.svg',
                    title: "Get a random ToDos",
                    color: Colors.greenAccent,
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
                    svg:
                        'https://pic.onlinewebfonts.com/thumbnails/icons_106515.svg',
                    title: "Limit & Skip ToDos",
                    color: Colors.lightGreenAccent,
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
                    svg:
                        'https://pic.onlinewebfonts.com/thumbnails/icons_548160.svg',
                    title: "Add a ToDos",
                    color: Colors.amberAccent,
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
