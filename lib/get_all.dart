import 'package:flutter/material.dart';
import 'package:todo_dummy/screen_detail.dart';
import 'package:todo_dummy/todo_task.dart';

class GetAll extends StatefulWidget {
  const GetAll({super.key});

  @override
  State<GetAll> createState() => _GetAllState();
}

class _GetAllState extends State<GetAll> {
  bool isGetUp = false;
  bool isWorkout = false;
  bool isMovie = false;
  bool isCamping = false;
  void detailScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ScreenDetail(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Get All ToDos",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          color: Colors.lightBlueAccent.withOpacity(0.2),
          child: Column(
            children: [
              TodoTask(
                value: isGetUp,
                color: Colors.cyanAccent,
                onPressed: detailScreen,
                onChanged: (bool? value) {
                  setState(() {
                    isGetUp = value ?? false;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TodoTask(
                todo: "WorkOut",
                onPressed: detailScreen,
                value: isWorkout,
                color: Colors.limeAccent,
                onChanged: (bool? value) {
                  setState(() {
                    isWorkout = value ?? false;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TodoTask(
                todo: "Movie",
                value: isMovie,
                color: Colors.purpleAccent,
                onChanged: (bool? value) {
                  setState(() {
                    isMovie = value ?? false;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TodoTask(
                todo: "Camping with Friend ",
                value: isCamping,
                color: Colors.pink,
                onChanged: (bool? value) {
                  setState(() {
                    isCamping = value ?? false;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
