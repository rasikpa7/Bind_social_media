import 'dart:async';
import 'dart:convert'as c;

import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json as Map<String, dynamic> )).toList();

          sink.add(users);
        },
      );

  static DateTime toDateTime(Timestamp value) {


    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }
}