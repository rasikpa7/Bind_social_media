import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/view/screens/screenwidgets/like_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserPosts extends StatefulWidget {
  final snap;
  UserPosts({Key? key, required this.snap}) : super(key: key);

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  bool isLikeAnimation = false;
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.snap['profImage']),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.snap['username'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Icon(Icons.menu)
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              FireStoreMethods().likePost(
                  widget.snap['postId'], user!.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimation = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.snap['postUrl']),
                        fit: BoxFit.cover),
                  ),
                  height: 400,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimation ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 120,
                    ),
                    isAnimating: isLikeAnimation,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimation = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user!.uid),
                    smallLike: true,
                    child: IconButton(
                      icon: widget.snap['likes'].contains(user.uid)?
                       Icon(
                        Icons.favorite,color: Colors.red,): Icon(
                        Icons.favorite_border_outlined,color: Colors.black,),
                      onPressed: () async {
                        FireStoreMethods().likePost(widget.snap['postId'],
                            user.uid, widget.snap['likes']);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Icon(Icons.chat_bubble_outline),
                  ),
                  Icon(Icons.send),
                ],
              ),
              Icon(Icons.bookmark),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Liked by '),
                Text(
                  '${widget.snap['likes'].length}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' people ',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: '${widget.snap['username']}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '  ${widget.snap['description']}')
                        ])),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'View all comments',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
