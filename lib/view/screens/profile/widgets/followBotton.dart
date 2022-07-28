import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FollowButton extends StatelessWidget {
  FollowButton(
      {Key? key,
      this.function,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      this.textColor})
      : super(key: key);
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: TextButton(
            child: Text(text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: function),
      ),
    );
  }
}

