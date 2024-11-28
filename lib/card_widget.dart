import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? height;
  final IconData? icon;
  const CardWidget({super.key, this.title, this.color, this.height, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 140,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(5, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.all_inbox,
            size: 24,
          ),
          Text(
            title ?? "",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
