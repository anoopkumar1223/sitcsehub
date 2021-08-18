import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/screens/details_screen.dart';
import 'package:sit_cse_hub/screens/verify_email.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';

class MyAuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static bool getLoggedIn() {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null)
      return false;
    else
      return true;
  }

  static void signIn(String email, String password, var context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User user = userCredential.user;
      Map userDetails = {
        'user': user,
      };
      if (auth.currentUser.emailVerified) {
        DocumentSnapshot yearSectionDetail = await FirebaseFirestore.instance
            .collection('studentYearSecInfo')
            .doc(email)
            .get()
            .then((value) {
          return value;
        });
        //print(yearSectionDetail.data());
        if (!yearSectionDetail.exists) {
          MyNavigation().pop(context: context);
          MyNavigation().pop(context: context);
          MyNavigation().pop(context: context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DetailsScreen(email: email)));
          MySharedPreference.preferences.setInt('screenFlag', 1);
        } else {
          String year = yearSectionDetail.data()['year'];
          String section = yearSectionDetail.data()['section'];
          String pic = yearSectionDetail.data()['pic'];
          try {
            DocumentSnapshot data = await FirebaseFirestore.instance
                .collection('student')
                .doc(year)
                .collection(section)
                .doc(email)
                .get();
            String fName = data['firstName'];
            print(fName);
            MySharedPreference.addStudentData(
              fName: fName,
              email: email,
              year: year,
              section: section,
              pic: pic,
            );
          } catch (e) {
            print(e);
          }
          MyNavigation().pop(context: context);
          MyNavigation().pop(context: context);
          MyNavigation().pop(context: context);
          MyNavigation().pushReplacement(
            context: context,
            screen: MyRoute.mainScreen,
            arguments: userDetails,
          );
        }
      } else {
        MyNavigation().pop(context: context);
        MyNavigation().pop(context: context);
        MyNavigation().pop(context: context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => VerifyScreen(email: email)));
      }
    } catch (e) {
      MyNavigation().pop(context: context);
      switch (e.code) {
        case 'network-request-failed':
          CustomErrorDialog.getErrorBox(
            context,
            'Please make sure your device has an internet connection',
          );
          break;
        case 'invalid-email':
          CustomErrorDialog.getErrorBox(
            context,
            'Please enter a valid Email Id',
          );
          break;
        case 'wrong-password':
          CustomErrorDialog.getErrorBox(
            context,
            'Incorrect password',
          );
          break;
        case 'user-not-found':
          CustomErrorDialog.getErrorBox(
            context,
            'You have not yet registered. Register now',
          );
          break;
        case 'user-disabled':
          CustomErrorDialog.getErrorBox(
            context,
            'User has been disabled due to security reasons. Contact your proctor.',
          );
          break;
        case 'too-many-requests':
          CustomErrorDialog.getErrorBox(
            context,
            'You have tried maximum times with wrong credentials. Please try later',
          );
          break;
        case 'operation-not-allowed':
          CustomErrorDialog.getErrorBox(
            context,
            'Operation not allowed. Try later or contact the administrator',
          );
          break;
        default:
          CustomErrorDialog.getErrorBox(context,
              e.message + ' Report this error here: support@sitcsehub.in');
          break;
      }
    }
  }

  static void passwordReset(BuildContext context, String email) async {
    try {
      if (email != null) email = email.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      MyNavigation().pop(context: context);
      MyNavigation().pop(context: context);
      CustomErrorDialog.getErrorBox(
        context,
        'Verification link has been sent to $email',
      );
    } on FirebaseAuthException catch (e) {
      MyNavigation().pop(context: context);
      MyNavigation().pop(context: context);
      switch (e.code) {
        case 'network-request-failed':
          CustomErrorDialog.getErrorBox(
            context,
            'Please make sure your device has an internet connection',
          );
          break;
        case 'invalid-email':
          CustomErrorDialog.getErrorBox(
            context,
            'Please enter a valid Email Id',
          );
          break;
        case 'user-not-found':
          CustomErrorDialog.getErrorBox(
            context,
            'You have not yet registered. Register now',
          );
          break;
        case 'too-many-requests':
          CustomErrorDialog.getErrorBox(
            context,
            'You have tried maximum times with wrong credentials. Please try later',
          );
          break;
        case 'unknown':
          CustomErrorDialog.getErrorBox(
            context,
            'Please enter the Email id',
          );
          break;
        default:
          CustomErrorDialog.getErrorBox(context,
              e.message + ' ' + 'Report this error here: support@sitcsehub.in');
          break;
      }
    }
  }

  static void signUp(
      String email, String password, BuildContext context) async {
    try {
      /*UserCredential userCredential = */ await auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      /*User user = userCredential.user;
      Map userDetails = {
        'user': user,
      };*/
      MyNavigation().pop(context: context);
      MyNavigation().pop(context: context);
      MyNavigation().pop(context: context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => VerifyScreen(email: email)));
    } catch (e) {
      MyNavigation().pop(context: context);
      print(e.code);
      switch (e.code) {
        case 'network-request-failed':
          CustomErrorDialog.getErrorBox(
            context,
            'Please make sure your device has an internet connection',
          );
          break;
        case 'invalid-email':
          CustomErrorDialog.getErrorBox(
            context,
            'Please enter a valid Email Id',
          );
          break;
        case 'email-already-in-use':
          CustomErrorDialog.getErrorBox(
            context,
            'User already exists. Please login.',
          );
          break;
        case 'weak-password':
          CustomErrorDialog.getErrorBox(
            context,
            'Password must be at least six characters long',
          );
          break;
        default:
          CustomErrorDialog.getErrorBox(context,
              e.message + ' Report this error here: support@sitcsehub.in');
          break;
      }
    }
  }

  static void professorSignIn(
      String email, String password, var context) async {
    DocumentSnapshot professorDetail = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(email)
        .get()
        .then((value) {
      return value;
    });
    if (professorDetail.exists) {
      String pName = professorDetail['name'];
      MySharedPreference.addProfessorData(name: pName, email: email);
      try {
        await auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        MyNavigation().pop(context: context);
        MyNavigation().pop(context: context);
        MyNavigation().pop(context: context);
        MyNavigation().pushReplacement(
          context: context,
          screen: MyRoute.mainScreen,
        );
        MySharedPreference.preferences.setInt('screenFlag', 1);
      } catch (e) {
        MyNavigation().pop(context: context);
        switch (e.code) {
          case 'network-request-failed':
            CustomErrorDialog.getErrorBox(
              context,
              'Please make sure your device has an internet connection',
            );
            break;
          case 'invalid-email':
            CustomErrorDialog.getErrorBox(
              context,
              'Please enter a valid Email Id',
            );
            break;
          case 'wrong-password':
            CustomErrorDialog.getErrorBox(
              context,
              'Incorrect password',
            );
            break;
          case 'user-not-found':
            CustomErrorDialog.getErrorBox(
              context,
              'You have not yet registered. Register now',
            );
            break;
          case 'user-disabled':
            CustomErrorDialog.getErrorBox(
              context,
              'User has been disabled due to security reasons. Contact your proctor.',
            );
            break;
          case 'too-many-requests':
            CustomErrorDialog.getErrorBox(
              context,
              'You have tried maximum times with wrong credentials. Please try later',
            );
            break;
          case 'operation-not-allowed':
            CustomErrorDialog.getErrorBox(
              context,
              'Operation not allowed. Try later or contact the administrator',
            );
            break;
          default:
            CustomErrorDialog.getErrorBox(context,
                e.message + ' Report this error here: support@sitcsehub.in');
            break;
        }
      }
    } else {
      MyNavigation().pop(context: context);
      CustomErrorDialog.getErrorBox(
        context,
        'Your account doesn\'t exists. Please contact your administrator',
      );
    }
  }
}
