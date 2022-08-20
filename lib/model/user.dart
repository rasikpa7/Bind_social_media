import 'dart:convert';

import 'package:bind/model/assets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}
class User {
  final String? email;
  final String? uid;
  final String? photoUrl;
  final String? username;
  final String? bio;
  final dynamic followers;
  final dynamic following;
   final DateTime? lastMessageTime;
   final String status;

  User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following,
      required this.lastMessageTime,
      required this.status});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
        'status':status
      };

  static User  fromSnap(DocumentSnapshot? snap) {

    var snapshot = snap?.data() as Map<String, dynamic>;
    
    debugPrint('movieTitlesecond: $snapshot');
    // print(snapshot['PhotoUrl'])

    return User(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'], 
        lastMessageTime: Utils.toDateTime(snapshot['lastMessageTime']),
        status: snapshot['status']
        );
  }
}
