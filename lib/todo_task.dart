import 'package:flutter/material.dart';
import 'package:todo_dummy/add_edit.dart';

class TodoTask extends StatelessWidget {
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
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///title of todo
            Expanded(
              child: Text(
                todo ?? "Get up",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            ///check box of todo
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
                        color: Colors.white,
                      ),
                      tooltip: 'Show menu',
                    );
                  },

                  ///List of menu
                  menuChildren: [
                    ///Update To Do
                    MenuItemButton(
                      leadingIcon: Icon(Icons.update),
                      child: Text(
                        "Update",
                        selectionColor: Colors.lightBlueAccent,
                      ),
                      onPressed: () {
                        ///showing Bottom Sheet of Update To Do
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => AddEdit(
                            option: "Edit To Do",
                          ),
                        );
                      },
                    ),

                    ///Delete To Do
                    MenuItemButton(
                      leadingIcon: Icon(Icons.delete),
                      child: Text(
                        "Delete",
                        selectionColor: Colors.lightBlueAccent,
                      ),

                      ///Showing dialog box
                      onPressed: () {
                        dialog(context);
                      },
                    )
                  ],
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
