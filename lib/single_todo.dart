import 'package:flutter/material.dart';

class SingleTodo extends StatelessWidget {
  const SingleTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            width: 200,
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                // TextField(
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Enter ID',
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Get"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
