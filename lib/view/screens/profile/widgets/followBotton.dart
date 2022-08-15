import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding:  EdgeInsets.only(bottom: 0.0,right: 5.h),
      child: Container(
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5.r),
        ),
        alignment: Alignment.center,
        child: TextButton(
            onPressed: function,
            child: Text(text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ))),
      ),
    );
  }
}

