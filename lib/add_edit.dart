import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dummy/get_all.dart';

class AddEdit extends StatefulWidget {
  final String? option;
  const AddEdit({super.key, this.option});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  TextEditingController taskController = TextEditingController();
  Future<void> _postData() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('https://dummyjson.com/todos/add'));
    request.body = json
        .encode({"todo": taskController.text, "completed": false, "userId": 5});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Create Successed'),
                content: Text(taskController.text + 'was created!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GetAll())),
                    child: const Text('Yes'),
                  ),
                ],
              ));
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                    color: Colors.lightBlueAccent,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.option ?? "Add To Do",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              size: 35,
                              color: Colors.white,
                            ))
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: TextField(
                          controller: taskController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Add To Do"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: _postData,
                        child: Text("Save"),
                        //style: MinColumnWidth(100, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
