import 'package:flutter/material.dart';
import 'package:todo_dummy/card_widget.dart';
import 'package:todo_dummy/get_all.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To Do List",
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                child: CardWidget(
              svg: 'https://pic.onlinewebfonts.com/thumbnails/icons_563230.svg',
              title: "Get all TODOs",
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GetAll()));
              },
            )),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CardWidget(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetAll()));
                          },
                          svg:
                              'https://pic.onlinewebfonts.com/thumbnails/icons_427403.svg',
                          title: "Get a single ToDos",
                          color: Colors.cyanAccent)),
                  const SizedBox(
                    width: 15,
                  ),
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
            Expanded(
              child: Row(
                children: [
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
                  Expanded(
                      child: CardWidget(
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
            const Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CardWidget(
                          svg:
                              'https://pic.onlinewebfonts.com/thumbnails/icons_215928.svg',
                          title: "Update a ToDos",
                          color: Colors.limeAccent)),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CardWidget(
                    svg:
                        'https://pic.onlinewebfonts.com/thumbnails/icons_548170.svg',
                    title: "Delete a ToDos",
                    color: Colors.white70,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
