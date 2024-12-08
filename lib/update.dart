import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_dummy/model/todo_model.dart';
import 'package:http/http.dart' as http;

class Update extends StatelessWidget {
  final TextEditingController updateController;
  final bool value;
  final void Function(bool?)? onChanged;
  const Update(
      {super.key,
      required this.updateController,
      required this.value,
      this.onChanged});

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
                          "Update ToDos",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                          controller: updateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                      tristate: true,
                      value: value,
                      onChanged: onChanged,
                      checkColor: (Colors.black),
                      activeColor: Colors.grey[300],
                      side: const BorderSide(width: 2, color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
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
