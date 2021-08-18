import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';
import 'package:sit_cse_hub/components/custom_icon_button.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/components/user_selection_component.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/resources/router.dart';

class UserSelectionScreen extends StatefulWidget {
  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  bool isStudent = false;
  bool isProfessor = false;
  UserType userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resource.color.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Text(
                  Resource.string.tellUsWhoYouAre,
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2,
                    fontFamily: Resource.string.bangers,
                  ),
                ),
              ),
              UserSelectionComponent(
                title: Resource.string.professor,
                image: Resource.image.professorGif,
                width: (isProfessor) ? 10.0 : 0,
                onTap: () {
                  setState(() {
                    isProfessor = true;
                    isStudent = false;
                    userType = UserType.PROFESSOR;
                  });
                },
              ),
              UserSelectionComponent(
                title: Resource.string.student,
                image: Resource.image.studentGif,
                width: (isStudent) ? 10.0 : 0,
                onTap: () {
                  setState(() {
                    isStudent = true;
                    isProfessor = false;
                    userType = UserType.STUDENT;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomIconButton(
        onPressed: () {
          if (isProfessor == false && isStudent == false)
            CustomErrorDialog.getErrorBox(
              context,
              'Please select one of the options',
            );
          else {
            if (isStudent == true)
              userType = UserType.STUDENT;
            else
              userType = UserType.PROFESSOR;
            MyRouter().getUserType(userType);
            Resource.navigation.push(
              context: context,
              screen: MyRoute.loginScreen,
              arguments: {
                'userType': userType,
              },
            );
          }
        },
        borderRadius: 30,
        horizontalPadding: 15,
        verticalPadding: 15,
        icon: FontAwesomeIcons.arrowRight,
        iconSize: 20,
      ),
    );
  }
}
