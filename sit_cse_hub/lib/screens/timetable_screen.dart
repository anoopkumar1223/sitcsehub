import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/info_view_edit_dropdown.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
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
          Resource.string.timeTable,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                Resource.image.timetableGif,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              InfoDropDown(
                title: 'I A',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'I B',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'I C',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'II A',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'II B',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'II C',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'III A',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'III B',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'III C',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'IV A',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'IV B',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'IV C',
                type: InfoType.TIMETABLE,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
