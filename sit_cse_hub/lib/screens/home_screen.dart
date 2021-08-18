import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';
import 'package:sit_cse_hub/components/homepage_options.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/services/firebase_services/firestore_service.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  Resource.string.getGreeting(
                    (MySharedPreference.getUserType() == 'student')
                        ? MySharedPreference.getStudentFirstName()
                        : 'Professor',
                  ),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 3,
                    fontFamily: Resource.string.bangers,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Lottie.asset(
                  (MySharedPreference.getUserType() == 'student')
                      ? Resource.image.homeGif
                      : Resource.image.professorGif,
                  height: 180,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Resource.string.home,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: Resource.string.lato,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: Resource.color.royalBlue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.chalkboardTeacher,
                        size: 40,
                        color: Resource.color.whiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        Resource.string.lecturePlan,
                        style: TextStyle(
                          fontSize: 18,
                          color: Resource.color.whiteColor,
                          fontFamily: Resource.string.lato,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: HomePageOption(
                        icon: FontAwesomeIcons.bullhorn,
                        color: Resource.color.coolblues,
                        title: Resource.string.notifications,
                        onTap: () {
                          Resource.navigation.push(
                            context: context,
                            screen: MyRoute.notificationScreen,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: HomePageOption(
                        icon: FontAwesomeIcons.clipboardList,
                        color: Resource.color.purplePink,
                        title: Resource.string.timeTable,
                        onTap: () async {
                          if (MySharedPreference.getUserType() == 'student') {
                            String url = await Database.getTimeTable(
                              MySharedPreference.getStudentYear(),
                              MySharedPreference.getStudentSection(),
                            );
                            if (url == null || url == "")
                              CustomErrorDialog.getErrorBox(
                                context,
                                'Timetable is not uploaded yet. Please contact your professor',
                              );
                            else
                              await launch(url);
                          } else if (MySharedPreference.getUserType() ==
                              'professor') {
                            MyNavigation().push(
                              context: context,
                              screen: MyRoute.timeTableScreen,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: HomePageOption(
                        icon: FontAwesomeIcons.calendar,
                        color: Resource.color.fbMessenger,
                        title: Resource.string.calendarOfEvents,
                        onTap: () async {
                          if (MySharedPreference.getUserType() == 'student') {
                            String url = await Database.getCalendarOfEvents();
                            if (url == null || url == "")
                              CustomErrorDialog.getErrorBox(
                                context,
                                'Calendar of events is not uploaded yet. Please contact your professor',
                              );
                            else
                              await launch(url);
                          }
                          if (MySharedPreference.getUserType() == 'professor') {
                            MyNavigation().push(
                                context: context,
                                screen: MyRoute.calendarOfEventsScreen);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: HomePageOption(
                        icon: FontAwesomeIcons.book,
                        color: Resource.color.seaBlue,
                        title: Resource.string.schemeSyllabus,
                        onTap: () async {
                          if (MySharedPreference.getUserType() == 'student') {
                            String url = await Database.getSchemeAndSyllabus(
                                MySharedPreference.getStudentYear());
                            if (url == null || url == "")
                              CustomErrorDialog.getErrorBox(
                                context,
                                'Scheme and syllabus is not uploaded yet. Please contact your professor',
                              );
                            else
                              await launch(url);
                          } else if (MySharedPreference.getUserType() ==
                              'professor') {
                            MyNavigation().push(
                              context: context,
                              screen: MyRoute.schemeSyllabusScreen,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
