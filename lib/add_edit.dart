import 'package:flutter/material.dart';

class AddEdit extends StatelessWidget {
  final String? option;
  const AddEdit({super.key, this.option});

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
                          option ?? "Add To Do",
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
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Add To Do"),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Save"),
            //style: MinColumnWidth(100, 40),
          ),
        ),
      ],
    );
  }
}
