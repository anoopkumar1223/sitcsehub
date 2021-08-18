import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/resources/router.dart';
import 'package:sit_cse_hub/screens/introduction_screen.dart';
import 'package:sit_cse_hub/screens/main_screen.dart';
import 'package:sit_cse_hub/screens/user_selection_screen.dart';
import 'package:sit_cse_hub/services/firebase_services/auth_service.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MySharedPreference.initializeSharedPreference();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignal();
  }

  void configOneSignal() {
    OneSignal.shared.init(Resource.constant.oneSignalAppId);
  }

  Widget getScreen(bool loginFlag, int screenFlag) {
    if (screenFlag == 0 && loginFlag == false)
      return OnBoardingPage();
    else if (screenFlag == 1 && loginFlag == false)
      return UserSelectionScreen();
    else
      return MainScreen();
  }

  @override
  Widget build(BuildContext context) {
    bool loginFlag = MyAuthService.getLoggedIn();
    int screenFlag = MySharedPreference.getScreenFlag();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
