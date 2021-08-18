import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/screens/calendar_screen.dart';
import 'package:sit_cse_hub/screens/login_screen.dart';
import 'package:sit_cse_hub/screens/main_screen.dart';
import 'package:sit_cse_hub/screens/notification_screen.dart';
import 'package:sit_cse_hub/screens/syllabus_screen.dart';
import 'package:sit_cse_hub/screens/timetable_screen.dart';
import 'package:sit_cse_hub/screens/signup_screen.dart';

class MyRouter {
  static UserType userType;

  UserType getUserType(UserType user) {
    userType = user;
    return user;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoute.loginScreen:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(userType: userType));
      case MyRoute.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      /*case MyRoute.verifyScreen:
        return MaterialPageRoute(builder: (_) => VerifyScreen());*/
      case MyRoute.mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case MyRoute.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case MyRoute.timeTableScreen:
        return MaterialPageRoute(builder: (_) => TimeTableScreen());
      case MyRoute.schemeSyllabusScreen:
        return MaterialPageRoute(builder: (_) => SyllabusScreen());
      case MyRoute.calendarOfEventsScreen:
        return MaterialPageRoute(builder: (_) => CalendarOfEventsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
