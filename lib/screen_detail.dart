import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/detail.dart';

class ScreenDetail extends StatelessWidget {
  const ScreenDetail({super.key});

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
                "Get Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Detail(
              icon: Icons.description,
              title: ("Get up and drink 1 glass of water"),
            ),
            Detail(
              icon: Icons.timer,
              title: "6:00am",
            ),
            Detail(
              icon: Icons.done,
              title: "Completed",
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
