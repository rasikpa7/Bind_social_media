import 'dart:developer';
import 'dart:typed_data';

import 'package:bind/model/user.dart' as model;
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';
import 'package:bind/view/screens/messageScreen/widget/chatScreen.dart';
import 'package:bind/view/screens/profile/widgets/editBioSheet.dart';
import 'package:bind/view/screens/profile/widgets/followBotton.dart';
import 'package:bind/view/screens/profile/widgets/userPostsViewScreen.dart';

import 'package:bind/view/screens/profile/widgets/currentUserPost.dart';
import 'package:bind/view/widgets/ImageAlertView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../feedScreen/widgets/user_post.dart';
import 'widgets/editProfileImageBottomSheet.dart';

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
    final currentLUser = Provider.of<UserProvider>(context, listen: false);
    final imageFile = Provider.of<UserProvider>(context).file;
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return
        // ? const Center(child: CircularProgressIndicator())
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.uid)
                .snapshots(),
            builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scaffold(
                        appBar: AppBar(
                          title: Text(
                            snapshot.data!.data()!['username'],
                            style: GoogleFonts.sourceCodePro(),
                          ),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? Stack(
                                          children: [
                                            GestureDetector(
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (builder) {
                                                      return ImageAlertView(
                                                        isProfile: true,
                                                        imageUrl: snapshot.data!
                                                                .data()![
                                                            'photoUrl'],
                                                      );
                                                    });
                                              },
                                              child: CircleAvatar(
                                                radius: 70,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        snapshot.data!.data()![
                                                            'photoUrl']),
                                                backgroundColor:
                                                    Colors.grey[400],
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 1,
                                                right: 1,
                                                child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          await currentLUser
                                                              .selectImage(
                                                                  context);

                                                          Bottomsheet()
                                                              .EditProfilePic(
                                                            context,
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.add_a_photo,
                                                          size: 18,
                                                        ))))
                                          ],
                                        )
                                      : GestureDetector(
                                        onLongPress: () {
                                            showDialog(
                                                    context: context,
                                                    builder: (builder) {
                                                      return ImageAlertView(
                                                        isProfile: true,
                                                        imageUrl: snapshot.data!
                                                                .data()![
                                                            'photoUrl'],
                                                      );
                                                    });
                                        },
                                        child: CircleAvatar(
                                            radius: 70,
                                            backgroundColor: Colors.grey[500],
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    snapshot.data!
                                                        .data()!['photoUrl']),
                                          ),
                                      ),
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? FollowButton(
                                          backgroundColor: Colors.red,
                                          borderColor: Colors.white,
                                          text: 'SignOut',
                                          function: () async {
                                            await _Bottomsheet(
                                                context, false, false);
                                          },
                                          textColor: Colors.white)
                                      : isFollowing
                                          ? Row(
                                              children: [
                                                FollowButton(
                                                    backgroundColor:
                                                        Colors.black,
                                                    borderColor: Colors.white,
                                                    text: 'Unfollow',
                                                    function: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              followId: snapshot
                                                                      .data!
                                                                      .data()![
                                                                  'uid']);
                                                      setState(() {
                                                        isFollowing = false;
                                                      });
                                                    },
                                                    textColor: Colors.white),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        8),
                                                            textStyle: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ChatScreen(
                                                            snap: model.User
                                                                .fromSnap(
                                                                    snapshot
                                                                        .data));
                                                      }));
                                                    },
                                                    child:
                                                        Icon(Icons.chat_bubble))
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                FollowButton(
                                                    backgroundColor:
                                                        Colors.blueAccent,
                                                    borderColor: Colors.white,
                                                    text: 'Follow',
                                                    function: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                              uid: FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              followId: snapshot
                                                                      .data!
                                                                      .data()![
                                                                  'uid']);

                                                      setState(() {
                                                        isFollowing = true;
                                                      });
                                                    },
                                                    textColor: Colors.white),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        8),
                                                            textStyle: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return ChatScreen(
                                                            snap: model.User
                                                                .fromSnap(
                                                                    snapshot
                                                                        .data));
                                                      }));
                                                    },
                                                    child:
                                                        Icon(Icons.chat_bubble))
                                              ],
                                            )
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
                                      if (snapshot.data!.data()!['uid'] ==
                                          user!.uid) {
                                        await _Bottomsheet(context, true, true);
                                      }
                                    },
                                    child: buildStatColum(
                                        snapshot.data!
                                            .data()!['followers']
                                            .length,
                                        'Followers'),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (snapshot.data!.data()!['uid'] ==
                                          user!.uid) {
                                        await _Bottomsheet(
                                            context, true, false);
                                      }
                                    },
                                    child: buildStatColum(
                                        snapshot.data!
                                            .data()!['following']
                                            .length,
                                        'Following'),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    snapshot.data!.data()!['username'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: FirebaseAuth
                                              .instance.currentUser!.uid ==
                                          widget.uid
                                      ? InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return EditBioSheet();
                                              },
                                            );
                                          },
                                          child: snapshot.data!
                                                      .data()!['bio'] ==
                                                  ''
                                              ? Text(
                                                  'Add Bio',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              : Text(
                                                  snapshot.data!.data()!['bio'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                        )
                                      : Text(
                                          snapshot.data!.data()!['bio'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ),
                                ),
                              ),
                              const Divider(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UserPostGrid(useruid: widget.uid),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
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
                  ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>?>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: isFollowers
                                  ? (snapshot.data?.docs[0]['followers']
                                          as List)
                                      .length
                                  : (snapshot.data?.docs[0]['following']
                                          as List)
                                      .length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<
                                        DocumentSnapshot<
                                            Map<String, dynamic>?>?>(
                                    stream: isFollowers
                                        ? FirebaseFirestore.instance
                                            .collection('users')
                                            .doc((snapshot.data?.docs[0]
                                                        ['followers']
                                                    as List)[index]
                                                .toString())
                                            .snapshots()
                                        : FirebaseFirestore.instance
                                            .collection('users')
                                            .doc((snapshot.data?.docs[0]
                                                        ['following']
                                                    as List)[index]
                                                .toString())
                                            .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.data!.data()!.isEmpty) {
                                        return const Center(
                                          child: Text(
                                            'no data',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }
                                      return FListWidget(
                                        snapshot: snapshot,
                                        isFollowers: isFollowers,
                                      );
                                    });
                              });
                        }
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
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
                                child: const Text('Cancel')),
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

class FListWidget extends StatelessWidget {
  bool isFollowers;
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>?>?> snapshot;
  FListWidget({Key? key, required this.snapshot, required this.isFollowers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).getUser;
    return Dismissible(
      onDismissed: (dismiss) async {
        await FireStoreMethods().followUser(
            uid: currentUser!.uid!, followId: snapshot.data!.data()!['uid']);
      },
      background: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).errorColor,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Remove User  '.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
      key: ObjectKey(snapshot.data!.data()!['uid']),
      child: snapshot.data!.data()!.length == 0
          ? const Center(
              child: Text(
                'No data',
                style: TextStyle(color: Colors.black),
              ),
            )
          : Card(
              color: Colors.blue,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      snapshot.data!.data()!['photoUrl']),
                  backgroundColor: Colors.grey[400],
                ),
                title: Text(snapshot.data!.data()!['username'],
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
    );
  }
}
