import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String? title;
  final IconData? icon;
  const Detail({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Icon(icon ?? Icons.description),
          SizedBox(
            width: 5,
          ),
          Text(title ?? "Detail"),
        ],
      ),
    );
  }
}
