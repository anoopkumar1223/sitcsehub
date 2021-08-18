import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/info_view_edit_dropdown.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class SyllabusScreen extends StatefulWidget {
  @override
  _SyllabusScreenState createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
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
          Resource.string.schemeSyllabus,
          style: TextStyle(
            color: Resource.color.blackColor,
            letterSpacing: 2,
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
                Resource.image.syllabusGif,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              InfoDropDown(
                title: 'I ',
                type: InfoType.SYLLABUS,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'II ',
                type: InfoType.SYLLABUS,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'III ',
                type: InfoType.SYLLABUS,
              ),
              SizedBox(
                height: 10,
              ),
              InfoDropDown(
                title: 'IV ',
                type: InfoType.SYLLABUS,
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
