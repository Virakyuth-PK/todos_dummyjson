import 'package:flutter/material.dart';
//import 'package:todo_dummy/add_edit.dart';

class ScreenDetail extends StatelessWidget {
  final String todo;
  final bool status;
  const ScreenDetail({
    super.key,
    required this.todo,
    required this.status,
  });
  //Icon change by Status{false or true}
  IconData icons() {
    return status ? Icons.done : Icons.close;
  }

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
                "${todo}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(icons()),
                  SizedBox(
                    width: 10,
                  ),
                  Text(status ? "Completed" : "Not Completed"),
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
