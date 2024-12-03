import 'package:flutter/material.dart';
//import 'package:todo_dummy/add_edit.dart';

class ScreenDetail extends StatelessWidget {
  final String? todo;
  final String? status;
  const ScreenDetail({super.key, this.todo, this.status});

  ///Screen Detail To Do
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Detail about ToDos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              child: Text(
                todo ?? "Get Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.description),
                  Text(todo ?? "Get up and drink 1 glass of water"),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.timer),
                  Text(todo ?? "6:00am"),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.done),
                  Text(status ?? "Completed"),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 20,
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   shape: CircleBorder(),
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (context) => AddEdit(),
      //     );
      //   },
      //   child: Icon(Icons.edit),
      // )
    );
  }
}
