import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/custom_dropdown.dart';
import 'package:sit_cse_hub/components/custom_icon_button.dart';
import 'package:sit_cse_hub/components/custom_notification_add.dart';
import 'package:sit_cse_hub/components/notification_bean.dart';
import 'package:sit_cse_hub/components/notification_component.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Stream<QuerySnapshot> stream = getStudentNotificationStream('Everyone');
  TextEditingController titleController;
  TextEditingController descController;
  String studentNotification = 'Everyone';
  List<String> professorNotificationTypeList = [
    'Everyone',
    'I all sections',
    'I A',
    'I B',
    'I C',
    'II all sections',
    'II A',
    'II B',
    'II C',
    'III all sections',
    'III A',
    'III B',
    'III C',
    'IV all sections',
    'IV A',
    'IV B',
    'IV C',
  ];
  List<String> studentNotificationTypeList = [
    '${MySharedPreference.getStudentYear()} ${MySharedPreference.getStudentSection()}',
    '${MySharedPreference.getStudentYear()} all sections',
    'Everyone',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resource.color.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Resource.color.blackColor,
        ),
        backgroundColor: Resource.color.backgroundColor,
        centerTitle: true,
        title: Text(
          Resource.string.notification,
          style: TextStyle(
            color: Resource.color.blackColor,
            letterSpacing: 5,
            fontFamily: Resource.string.bangers,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            15,
            30,
            15,
            20,
          ),
          child: Column(
            children: [
              Lottie.asset(
                Resource.image.notificationGif,
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              (MySharedPreference.getUserType() == 'professor')
                  ? CustomIconButton(
                      onPressed: () {
                        CustomNotificationAdd.getNotificationAdd(
                          context: context,
                          titleController: titleController,
                          descController: descController,
                        );
                      },
                      borderRadius: 50,
                      horizontalPadding: 20,
                      verticalPadding: 20,
                      icon: Icons.add,
                      iconSize: 30,
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              CustomDropDown(
                title: '',
                formValidator: (value) {},
                options: (MySharedPreference.getUserType() == 'student')
                    ? studentNotificationTypeList
                    : professorNotificationTypeList,
                selectedOption: studentNotification,
                onChanged: (newValue1) {
                  setState(() {
                    studentNotification = newValue1;
                    if (MySharedPreference.getUserType() == 'student') {
                      stream =
                          getStudentNotificationStream(studentNotification);
                    } else {
                      List<String> details = studentNotification.split(' ');
                      stream = getProfessorNotificationStream(details);
                    }
                  });
                },
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20,
              ),
              getStreamBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  static Stream<QuerySnapshot> getStudentNotificationStream(String type) {
    if (type == 'Everyone') {
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc('everyone')
          .collection('everyone')
          .orderBy('dateTime', descending: true)
          .snapshots();
    } else if (type ==
        '${MySharedPreference.getStudentYear()} ${MySharedPreference.getStudentSection()}') {
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc(MySharedPreference.getStudentYear())
          .collection(MySharedPreference.getStudentSection())
          .orderBy('dateTime', descending: true)
          .snapshots();
    } else if (type == '${MySharedPreference.getStudentYear()} all sections') {
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc(MySharedPreference.getStudentYear())
          .collection('allSections')
          .orderBy('dateTime', descending: true)
          .snapshots();
    }
  }

  static Stream<QuerySnapshot> getProfessorNotificationStream(
      List<String> type) {
    if (type.length == 1) {
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc('everyone')
          .collection('everyone')
          .orderBy('dateTime', descending: true)
          .snapshots();
    } else if (type.length == 2) {
      print(type[1]);
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc(type[0])
          .collection(type[1])
          .orderBy('dateTime', descending: true)
          .snapshots();
    } else if (type.length == 3) {
      return FirebaseFirestore.instance
          .collection('notifications')
          .doc(type[0])
          .collection('allSections')
          .orderBy('dateTime', descending: true)
          .snapshots();
    }
  }

  getStreamBuilder() {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData != true) {
          return SpinKitFadingCircle(
            color: Resource.color.primaryTheme,
            size: 50.0,
          );
        }
        if (snapshot.data.docs.length == 0) {
          return Text(
            'No notifications here',
            style: TextStyle(
              fontFamily: Resource.string.lato,
              letterSpacing: 1,
              fontSize: 20,
            ),
          );
        }
        return Column(
          children: snapshot.data.docs.map((document) {
            return Column(
              children: [
                NotificationComponent(
                  notificationBean: NotificationBean(
                    title: document['title'],
                    desc: document['desc'],
                    faculty: document['faculty'],
                    dateTime: document['dateTime'],
                    attachmentUrl: document['attachmentUrl'],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
