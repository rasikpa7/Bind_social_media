import 'package:bind/utils/utils.dart';
import 'package:bind/view/screens/profile/widgets/followBotton.dart';
import 'package:bind/view/screens/profileScreen/widgets/currentUserPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  final uid;
  Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData = {};
  int postlenght=0;

  bool isFollowing=false;
  
  bool isLoading=false;
  @override
  void initState() {

    // TODO: implement initState
    

    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading=true;
    });
    
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();



    var postSnap=await FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    postlenght=postSnap.docs.length;
      userData = snap.data()!;
      isFollowing=snap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading=false;
      });
    } catch (e) {
      showSnackBarr(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?
   const  Center(
      child :CircularProgressIndicator()
    ):
    Scaffold(
      appBar: AppBar(
        title: Text(userData['username']),
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
                  FirebaseAuth.instance.currentUser!.uid==widget.uid?  FollowButton(
                        backgroundColor: Colors.black,
                        borderColor: Colors.blue,
                        text: 'Edit Profile',
                        function: () {},
                        textColor: Colors.white):
                        isFollowing?
                         FollowButton(
                        backgroundColor: Colors.black,
                        borderColor: Colors.blue,
                        text: 'Unfollow',
                        function: () {},
                        textColor: Colors.white):
                         FollowButton(
                        backgroundColor: Colors.black,
                        borderColor: Colors.blue,
                        text: 'Follow',
                        function: () {},
                        textColor: Colors.white)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildStatColum(postlenght, 'Posts'),
                    const SizedBox(
                      width: 30,
                    ),
                    buildStatColum(userData['followers'].length, 'Followers'),
                    const SizedBox(
                      width: 25,
                    ),
                    buildStatColum(userData['following'].length, 'Following')
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
           Expanded(child: UserPostGrid(useruid:widget.uid ))
          
        ],
      ),
    );
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
