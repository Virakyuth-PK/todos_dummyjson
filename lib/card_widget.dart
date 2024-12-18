import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? height;
  final String? svg;
  final IconData? icon;
  final void Function()? onPressed;
  const CardWidget({
    super.key,
    this.title,
    this.color,
    this.height,
    this.svg,
    this.icon,
    this.onPressed,
  });

  ///Reusable Widget
  ///Use by Home Screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: height ?? 200,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: (color ?? Colors.blue).withOpacity(0.6),
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.network(
              svg ?? 'https://www.svgrepo.com/show/374674/folder.svg',
              //color: Colors.white,
              height: 30,
            ),

            ///title of button
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
