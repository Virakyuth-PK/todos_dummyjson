import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';

class TodoTask extends StatelessWidget {
  //final int? id;
  final String? todo;
  final void Function(bool?)? onChanged;
  final bool? value;
  final Color color;
  final void Function()? onPressed;
  TodoTask({
    super.key,
    this.todo,
    this.value,
    this.onChanged,
    this.color = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              todo ?? "Get up",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Row(
              children: [
                Checkbox(
                  tristate: true,
                  value: value,
                  onChanged: onChanged,
                  checkColor: (Colors.white),
                  activeColor: color.withOpacity(0.4),
                  side: BorderSide(width: 2, color: Colors.white),
                ),
                //
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddEdit(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: color.withOpacity(0.4),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(2, 2))
            ],
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
