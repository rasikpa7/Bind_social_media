import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';
import 'package:bind/view/screens/commentScreen/widgets/commets_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final User? user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('commets'),
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: 55.h,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:16.0,right: 8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Comment as  @${user!.username}', border: InputBorder.none),
                ),
              ),
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                child: const Text('Post',
                style: TextStyle(
                  color: Colors.blueAccent
                ),),
              ),
            
            )
          ],
        ),
      )),
    );
  }
}
