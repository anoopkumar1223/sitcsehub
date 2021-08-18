import 'package:flutter/cupertino.dart';

class NotificationBean {
  final String title;
  final String desc;
  final String faculty;
  final String dateTime;
  final String attachmentUrl;

  NotificationBean({
    @required this.title,
    @required this.desc,
    @required this.faculty,
    @required this.dateTime,
    @required this.attachmentUrl,
  });
}
