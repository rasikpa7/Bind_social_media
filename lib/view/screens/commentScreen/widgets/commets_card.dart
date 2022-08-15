import 'package:bind/model/user.dart';

import 'package:bind/view/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
   CommentCard({Key? key,  required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User? user=Provider.of<UserProvider>(context).getUser;
  
   return InkWell(
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
    Profile(uid: widget.snap['uid']))),
     child: Container(
      padding:  EdgeInsets.symmetric(
        vertical: 18.h,
        horizontal: 
        16.w,
   
      ),
      child: Row(
        children: [
           CircleAvatar(
            backgroundImage:  NetworkImage(widget.snap['profilePic']),
            radius: 18.r,
          ),
   
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left:8.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: 
                   TextSpan(children: [
                    TextSpan(
                      text: widget.snap['name'],style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                      
                      )
                    ),
                     TextSpan(
                      text: '   ${widget.snap['text']}',style: TextStyle(color: Colors.black,
                      
                      )
                    )
                  ])
                  ),
                   Padding(
                     padding:  EdgeInsets.only(left:7.0.w),
                     child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(fontSize: 11.sp,
                          color: Colors.grey[800]),
                      ),
                   ),
                ],
              ),
            ),
          ),
  
        ],
      ),
   
     ),
   );
    
  }
}