import 'package:flutter/material.dart';

class TodoTask extends StatelessWidget {
  //final int? id;
  final String? todo;
  final void Function(bool?)? onChanged;
  final bool? value;
  final Colors? color;
  TodoTask({
    super.key,
    this.todo,
    this.value,
    this.onChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Checkbox(
            tristate: true,
            value: value,
            onChanged: onChanged,
            checkColor: Colors.black,
            activeColor: Colors.white,
          ),
          Text(
            todo ?? "Get up",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: (Colors.white),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(8)),
    );
  }
}
