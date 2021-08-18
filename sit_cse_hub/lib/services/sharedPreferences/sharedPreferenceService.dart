import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static SharedPreferences preferences;

  static void initializeSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void addStudentData({
    @required String fName,
    @required String email,
    @required String year,
    @required String section,
    @required String pic,
  }) {
    preferences.setString('fName', fName);
    preferences.setString('email', email);
    preferences.setString('year', year);
    preferences.setString('section', section);
    preferences.setString('pic', pic);
    preferences.setString('userType', 'student');
  }

  static Map<String, String> getStudentData() {
    Map<String, String> details = {};
    details['fName'] = preferences.getString('fName');
    details['email'] = preferences.getString('email');
    details['year'] = preferences.getString('year');
    details['section'] = preferences.getString('section');
    details['pic'] = preferences.getString('pic');
    return details;
  }

  static String getStudentFirstName() {
    return preferences.getString('fName');
  }

  static String getStudentLastName() {
    return preferences.getString('lName');
  }

  static String getStudentEmail() {
    return preferences.getString('email');
  }

  static String getStudentPhone() {
    return preferences.getString('phone');
  }

  static String getStudentYear() {
    return preferences.getString('year');
  }

  static String getStudentSection() {
    return preferences.getString('section');
  }

  static String getStudentPic() {
    return preferences.getString('pic');
  }

  static void addProfessorData({
    @required String name,
    @required String email,
  }) {
    preferences.setString('pName', name);
    preferences.setString('pEmail', email);
    preferences.setString('userType', 'professor');
  }

  static String getProfessorName() {
    return preferences.getString('pName');
  }

  static String getProfessorEmail() {
    return preferences.getString('pEmail');
  }

  static String getUserType() {
    return preferences.getString('userType');
  }

  static int getScreenFlag() {
    try {
      if (preferences.getInt('screenFlag') == null) {
        preferences.setInt('screenFlag', 0);
        return 0;
      } else
        return preferences.getInt('screenFlag');
    } catch (e) {
      return 0;
    }
  }
}
