import 'dart:typed_data';

import 'package:bind/resources/storage_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../model/post.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload the post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = 'Some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String PostId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(PostId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(PostId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print('text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId, BuildContext context) async {
    String res;
    try {
      await _firestore.collection('posts').doc(postId).delete();
      showSnackBarr('Post Deleted', context);
    } catch (e) {
      print(e.toString());
      showSnackBarr(e.toString(), context);
    }
  }

  Future<void> followUser(
      {required String uid, required String followId}) async {


        try{
        DocumentSnapshot snap= await _firestore.collection('users').doc(uid).get();
    List following= (snap.data() as dynamic)['following'];
    if(following.contains(followId)){
      await _firestore.collection('users').doc(followId).update(
        {
          'followers':FieldValue.arrayRemove([uid])
        }
      );
      await _firestore.collection('users').doc(uid).update(
        {
          'following':FieldValue.arrayRemove([followId])
        }
      );

    }else{

        await _firestore.collection('users').doc(followId).update(
        {
          'followers':FieldValue.arrayUnion([uid])
        }
      );
      await _firestore.collection('users').doc(uid).update(
        {
          'following':FieldValue.arrayUnion([followId])
        }
      );

    }
        }catch(e){

        }

       
      }
}
