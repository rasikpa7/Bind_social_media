import 'dart:developer';

import 'package:bind/model/user.dart' as model;
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';
import 'package:bind/view/screens/profile/widgets/followBotton.dart';
import 'package:bind/view/screens/profile/widgets/userPostsViewScreen.dart';

import 'package:bind/view/screens/profileScreen/widgets/currentUserPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final uid;
  Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData = {};
  int postlenght = 0;
  var postSnap;

  bool isFollowing = false;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postlenght = postSnap.docs.length;
      userData = snap.data()!;
      isFollowing = snap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackBarr(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                userData['username'],
                style: GoogleFonts.sourceCodePro(),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                          ),
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  backgroundColor: Colors.red,
                                  borderColor: Colors.white,
                                  text: 'SignOut',
                                  function: () async {
                                    await _Bottomsheet(context, false, false);
                                  },
                                  textColor: Colors.white)
                              : isFollowing
                                  ? FollowButton(
                                      backgroundColor: Colors.black,
                                      borderColor: Colors.white,
                                      text: 'Unfollow',
                                      function: () async {
                                        await FireStoreMethods().followUser(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            followId: userData['uid']);
                                        setState(() {
                                          isFollowing = false;
                                        });
                                      },
                                      textColor: Colors.white)
                                  : FollowButton(
                                      backgroundColor: Colors.blueAccent,
                                      borderColor: Colors.white,
                                      text: 'Follow',
                                      function: () async {
                                        await FireStoreMethods().followUser(
                                            uid: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            followId: userData['uid']);

                                        setState(() {
                                          isFollowing = true;
                                        });
                                      },
                                      textColor: Colors.white)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildStatColum(postlenght, 'Posts'),
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              if (userData['uid'] == user!.uid) {
                                await _Bottomsheet(context, true, true);
                              }
                            },
                            child: buildStatColum(
                                userData['followers'].length, 'Followers'),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () async {
                              if (userData['uid'] == user!.uid) {
                                await _Bottomsheet(context, true, false);
                              }
                            },
                            child: buildStatColum(
                                userData['following'].length, 'Following'),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            userData['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            userData['bio'],
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Expanded(
                    child: InkWell(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserPostViewScreen(usersnap: userData)))),
                        child: UserPostGrid(useruid: widget.uid)))
              ],
            ),
          );
  }

  _Bottomsheet(BuildContext context, bool isFList, bool isFollowers) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: isFList ? 350 : 110.h,
            color: const Color(0xFF737373),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: isFList
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data == null) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              // print(
                              //     "---------------------------------${snapshot.data!.docs[index]["followers"][0]}");
                              return StreamBuilder(
                                  stream: isFollowers?
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .where("uid",
                                          isEqualTo: snapshot.data?.docs[index]
                                              ["followers"][index])
                                      .snapshots():
                                      FirebaseFirestore.instance
                                      .collection('users')
                                      .where("uid",
                                          isEqualTo: snapshot.data?.docs[index]
                                              ["following"][index])
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot1) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.data!.docs == null) {
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    // log(snapshot1.data!.docs.toString());
                                    return Card(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot1.data?.docs[index]
                                                  ['photoUrl']),
                                        ),
                                        title: Text(snapshot1.data?.docs[index]
                                            ['username']),
                                      ),
                                    );
                                  });
                            });
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Do You Want To Signout?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel')),
                            SizedBox(
                              width: 50.w,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await AuthMethods().signOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              LogInScreen())));
                                },
                                child: const Text('OK'))
                          ],
                        )
                      ],
                    ),
            ),
          );
        });
  }

  Column buildStatColum(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        )
      ],
    );
  }

  final kwidth = const SizedBox(
    width: 20,
  );
}
