import 'package:flutter/material.dart';
import 'package:todo_dummy/card_widget.dart';

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
        child: const Column(
          children: [
            Expanded(
                child: CardWidget(
              icon: Icons.folder,
              title: "Get all TODOs",
            )),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CardWidget(
                    icon: Icons.highlight,
                    title: "Get a single ToDos",
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CardWidget(
                    icon: Icons.generating_tokens,
                    title: "Get a random ToDos",
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CardWidget(
                    icon: Icons.skip_next,
                    title: "Limit & Skip ToDos",
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CardWidget(
                    icon: Icons.add,
                    title: "Add a ToDos",
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: CardWidget(
                    icon: Icons.update,
                    title: "Update a ToDos",
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CardWidget(
                    icon: Icons.delete,
                    title: "Delete a ToDos",
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
