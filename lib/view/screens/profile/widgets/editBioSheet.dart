
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';

class EditBioSheet extends StatelessWidget {
  TextEditingController editBioController = TextEditingController();
  EditBioSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    
      padding: EdgeInsets.only(bottom: 300.h,
      left: 5.w,right: 5.w),
      color: const Color(0xFF737373),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10.r)),
        height: 200.h,
        child: Column(
          
          children: [
            SizedBox(
              height: 8.h,
            ),
           const  Text(
              'Add Bio',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.circular(10.0.r),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0.h),
                    child: TextFormField(
                      controller: editBioController,
                        decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'add you bio here',
                    )))),
                    SizedBox(height: 4.h,),
            
                    SizedBox(width: double.infinity,
                    height: 40.h,
                      child: Consumer<UserProvider>(
                        builder: (context, value, child) => 
                        ElevatedButton(onPressed: ()async{
                         await  value.editBio(context, editBioController.text);
                         Navigator.of(context).pop();
                        }, child: const  Text('Submit')),
                      ))
          ],
        ),
      ),
    );
  }
}
