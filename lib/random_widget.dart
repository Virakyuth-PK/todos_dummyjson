import 'package:flutter/material.dart';

class RandomWidget extends StatelessWidget {
  final String? title;
  final String? value;
  const RandomWidget({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "$title ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            "$value",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
          ]),
    );
  }
}
