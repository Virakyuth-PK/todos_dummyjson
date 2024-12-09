import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';
import 'package:todo_dummy/update.dart';

class TodoTask extends StatelessWidget {
  final String? todo;
  final void Function(bool?)? onChanged;
  final bool? value;
  final Color color;
  final void Function()? onPressed;
  final void Function()? onDelete;
  final void Function()? onUpdate;
  TodoTask({
    super.key,
    this.todo,
    this.value,
    this.onChanged,
    this.color = Colors.white,
    this.onPressed,
    this.onDelete,
    this.onUpdate,
  });
  void dialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete To Do'),
        content: const Text('Do you want to delete this task?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Yes'),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  ///Reusable Widget
  ///Use by Screen 2 or Get all Screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 7, 10, 7),
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 3))
            ],
            // border: Border.fromBorderSide(BorderSide(
            //     style: BorderStyle.solid, color: Colors.grey, width: 1)),
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(10), bottom: Radius.circular(10))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 5,
                  color: Colors.lightBlueAccent,
                ),

                ///title of todo
                Expanded(
                  child: Text(
                    todo ?? "Get up",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),

                ///check box of todo
                Row(
                  children: [
                    Checkbox(
                      tristate: true,
                      value: value,
                      onChanged: onChanged,
                      checkColor: (Colors.black),
                      activeColor: Colors.grey[300],
                      side: const BorderSide(width: 2, color: Colors.black),
                    ),

                    ///menu item {update,delete}
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          tooltip: 'Show menu',
                        );
                      },

                      ///List of menu
                      menuChildren: [
                        ///Update To Do
                        MenuItemButton(
                          leadingIcon: const Icon(Icons.update),
                          child: const Text(
                            "Update",
                            selectionColor: Colors.lightBlueAccent,
                          ),
                          onPressed: onUpdate,
                        ),

                        ///Delete To Do
                        MenuItemButton(
                            leadingIcon: const Icon(Icons.delete),
                            child: const Text(
                              "Delete",
                            ),

                            ///Showing dialog box
                            onPressed: onDelete)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
