import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';

class Database {
  static Future addStudentData({
    @required String fName,
    @required String lName,
    @required String usn,
    @required String phone,
    @required String email,
    @required String year,
    @required String section,
    @required String pic,
    @required BuildContext context,
  }) async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String tokenId = status.subscriptionStatus.userId;

    DocumentReference studentDocument;
    DocumentReference infoDocument;
    Map<String, dynamic> studentData = {
      'firstName': fName,
      'lastName': lName,
      'usn': usn,
      'phone': phone,
      'tokenId': tokenId,
      'pic': pic,
    };
    Map<String, dynamic> yearSecInfo = {
      'year': year,
      'section': section,
    };
    infoDocument =
        FirebaseFirestore.instance.collection('studentYearSecInfo').doc(email);
    studentDocument = FirebaseFirestore.instance
        .collection('student')
        .doc(year)
        .collection(section)
        .doc(email.toLowerCase());
    try {
      await infoDocument.set(yearSecInfo);
      return await studentDocument.set(studentData);
    } catch (error) {
      CustomErrorDialog.getErrorBox(context, error.message);
    }
  }

  static Future addNotification({
    @required String title,
    @required String desc,
    @required sendTo,
    String year,
    String section,
    @required String faculty,
    @required String dateTime,
    String attachmentUrl,
    @required BuildContext context,
  }) async {
    Map<String, dynamic> notification = {
      'title': title,
      'desc': desc,
      'faculty': faculty,
      'dateTime': dateTime,
      'attachmentUrl': attachmentUrl,
    };
    if (sendTo == 0) {
      try {
        FirebaseFirestore.instance
            .collection('notifications')
            .doc('everyone')
            .collection('everyone')
            .add(notification);
      } catch (error) {
        CustomErrorDialog.getErrorBox(context, error);
      }
    } else {
      if (section == 'All sections') section = 'allSections';
      try {
        FirebaseFirestore.instance
            .collection('notifications')
            .doc(year)
            .collection(section)
            .add(notification);
      } catch (error) {
        CustomErrorDialog.getErrorBox(context, error);
      }
    }
  }

  static Future addScheme(
      String attachmentUrl, BuildContext context, String year, String section) {
    Map<String, dynamic> notification = {
      'attachmentUrl': attachmentUrl,
    };
    try {
      FirebaseFirestore.instance
          .collection('schemeAndSyllabus')
          .doc('schemeAndSyllabus')
          .update({'$year $section': attachmentUrl});
    } catch (error) {
      CustomErrorDialog.getErrorBox(context, error);
    }
  }

  static Future addTimeTable(
      String attachmentUrl, BuildContext context, String year, String section) {
    Map<String, dynamic> notification = {
      'attachmentUrl': attachmentUrl,
    };
    try {
      FirebaseFirestore.instance
          .collection('timetable')
          .doc('timetable')
          .update({'$year $section': attachmentUrl});
    } catch (error) {
      CustomErrorDialog.getErrorBox(context, error);
    }
  }

  static Future addCalendarOfEvents(
      String attachmentUrl, BuildContext context) {
    Map<String, dynamic> notification = {
      'attachmentUrl': attachmentUrl,
    };
    try {
      FirebaseFirestore.instance
          .collection('calendarOfEvents')
          .doc('calendarOfEvents')
          .update({'url': attachmentUrl});
    } catch (error) {
      CustomErrorDialog.getErrorBox(context, error);
    }
  }

  static Future<QuerySnapshot> getSnapShot(String year, String sec) async {
    QuerySnapshot snapshots = await FirebaseFirestore.instance
        .collection('student')
        .doc(year)
        .collection(sec)
        .get();
    return snapshots;
  }

  static Future<List<String>> getAllSectionTokens(String year) async {
    List<String> tokens = [];
    try {
      QuerySnapshot snapshots = await getSnapShot(year, 'A');
      snapshots.docs.forEach((e) {
        tokens.add(e['tokenId']);
      });
      snapshots = await getSnapShot(year, 'B');
      snapshots.docs.forEach((e) {
        tokens.add(e['tokenId']);
      });
      snapshots = await getSnapShot(year, 'C');
      snapshots.docs.forEach((e) {
        tokens.add(e['tokenId']);
      });
    } catch (e) {}
    return tokens;
  }

  static Future<List<String>> getTokens(
      String year, String section, int sendTo) async {
    List<String> tokens = [];
    if (sendTo == 0) {
      tokens = tokens + await getAllSectionTokens('I');
      tokens = tokens + await getAllSectionTokens('II');
      tokens = tokens + await getAllSectionTokens('III');
      tokens = tokens + await getAllSectionTokens('IV');
    } else {
      if (section == 'All sections') {
        tokens = tokens + await getAllSectionTokens(year);
      } else {
        try {
          QuerySnapshot snapshots = await getSnapShot(year, section);
          snapshots.docs.forEach((e) {
            tokens.add(e['tokenId']);
          });
        } catch (e) {}
      }
    }
    return tokens;
  }

  static Future<String> getSchemeAndSyllabus(String year) async {
    String url;
    await FirebaseFirestore.instance
        .collection('schemeAndSyllabus')
        .doc('schemeAndSyllabus')
        .get()
        .then((value) {
      url = value.data()[year];
    });
    return url;
  }

  static Future<String> getCalendarOfEvents() async {
    String url;
    await FirebaseFirestore.instance
        .collection('calendarOfEvents')
        .doc('calendarOfEvents')
        .get()
        .then((value) {
      url = value.data()['url'];
    });
    return url;
  }

  static Future<String> getTimeTable(String year, String sec) async {
    String url;
    await FirebaseFirestore.instance
        .collection('timetable')
        .doc('timetable')
        .get()
        .then((value) {
      url = value.data()['$year $sec'];
    });
    return url;
  }
}
