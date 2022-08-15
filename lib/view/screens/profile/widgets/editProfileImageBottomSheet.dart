import 'dart:typed_data';

import 'package:bind/model/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';

class Bottomsheet {
  Future EditProfilePic(
    BuildContext context,
  ) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    //  final image = Provider.of<UserProvider>(context,listen: false).file;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.h))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              color: const Color(0xFF737373),
              child: Container(
                margin: EdgeInsets.all(10.r),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                height: 300.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, value, child) => InkWell(
                            onTap: () async {
                              await user.editProfilePicPmethod(
                                  context: context, image: value.file!);
                              user.addnulltoImageFile();

                              Navigator.of(context).pop();
                              showSnackBarr('Posted  !', context);
                            },
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.h),
                                child: Text('Post',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<UserProvider>(
                      builder: (context, value, child) => value.file == null
                          ? const Center(
                              child: Text('pick some photo'),
                            )
                          : Card(
                              color: Colors.grey,
                              child: Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    image: DecorationImage(
                                        image: MemoryImage(value.file!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ));
  }
}
