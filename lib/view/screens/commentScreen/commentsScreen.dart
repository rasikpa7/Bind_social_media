import 'package:bind/model/user.dart';

import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/view/screens/commentScreen/widgets/commets_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_provider.dart';

class CommentsScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final snap;
  CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('commets'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(snap['postId'])
              .collection('comments').orderBy('datePublished',descending: true)
              .snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                  return CommentCard(snap: snapshot.data!.docs[index].data(),);
                });
              },
              ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: 55.h,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(left: 16.w, right: 8.w),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user!.photoUrl!),
              radius: 18.r,
            ),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.only(left: 16.0.w, right: 8.w),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Comment as  @${user.username}',
                      border: InputBorder.none),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FireStoreMethods().postComment(
                    snap['postId'],
                    _textController.text,
                    user.uid!,
                    user.username!,
                    user.photoUrl!);
                _textController.clear();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.w,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
