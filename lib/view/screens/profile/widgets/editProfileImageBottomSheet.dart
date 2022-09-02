import 'dart:typed_data';

import 'package:bind/model/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';


import '../../../../controller/user_provider.dart';



class EditProfileBottomSheetContainer extends StatelessWidget {
  
  const EditProfileBottomSheetContainer({
    Key? key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
       final user = Provider.of<UserProvider>(context, listen: false);
     final userImage = Provider.of<UserProvider>(context);
    return Container(
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
                    InkWell(
                        onTap: () async {
                         final res= await user.editProfilePicPmethod(
                              context: context,
                              //  image: userImage.file!
                               );
                               Get.snackbar('status',res,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white,
                               backgroundColor: Colors.blueAccent);
                              //  showSnackBarr(res, context);
                               
                          // user.addnulltoImageFile();

                          // Get.back();

                          Navigator.of(context).pop();
                         
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
                   
                  ],
                ),
                // Consumer<UserProvider>(
                //   builder: (context, value, child) => value.file == null
                //       ? const Center(
                //           child: Text('pick some photo'),
                //         )
                      // :
                      userImage.file!=null?
                       Card(
                          color: Colors.grey,
                          child: userImage.profileImageUpload?
                          Container(height: 200.h,
                          color: Colors.white,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ):
                          Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                image: DecorationImage(
                                    image: MemoryImage(userImage.file!),
                                    fit: BoxFit.cover)),
                          ),
                        ):
                        const Center(
                          child: Text('pick some photo'),
                        )
            
              ],
            ),
          ),
        );
  }
}
