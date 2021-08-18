import 'package:flutter/material.dart';
import 'package:sit_cse_hub/components/custom_circle_avatar.dart';
import 'package:sit_cse_hub/components/main_page_navbutton.dart';
import 'package:sit_cse_hub/components/main_page_navbutton_tapped.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/screens/home_screen.dart';
import 'package:sit_cse_hub/screens/settings_screen.dart';
import 'package:sit_cse_hub/screens/todo_screen.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var todoIcon = Icons.list;
  var homeIcon = Icons.home;
  var profileIcon = Icons.settings;

  bool todoButtonPressed = false;
  bool homeButtonPressed = true;
  bool profileButtonPressed = false;

  void pressTodo() {
    setState(() {
      todoButtonPressed = true;
      homeButtonPressed = false;
      profileButtonPressed = false;
    });
  }

  void pressHome() {
    setState(() {
      todoButtonPressed = false;
      homeButtonPressed = true;
      profileButtonPressed = false;
    });
  }

  void pressProfile() {
    setState(() {
      todoButtonPressed = false;
      homeButtonPressed = false;
      profileButtonPressed = true;
    });
  }

  Widget getScreen() {
    if (todoButtonPressed == true)
      return TodoScreen();
    else if (homeButtonPressed == true)
      return HomeScreen();
    else
      return SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          60,
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Resource.color.backgroundColor,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 10,
              ),
              child: CustomCircleAvatar(
                  radius: 25,
                  imagePath: (MySharedPreference.getUserType() == 'student')
                      ? MySharedPreference.getStudentPic()
                      : 'assets/images/profile_boy.json',
                  onPressed: () {}),
            )
          ],
          title: Text(
            Resource.string.sitCseHub,
            style: TextStyle(
              color: Resource.color.blackColor,
              letterSpacing: 4,
              fontFamily: Resource.string.bangers,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Resource.color.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: getScreen(),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            thickness: 1.5,
            height: 1.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (todoButtonPressed)
                    ? MainPageNavButtonTapped(
                        icon: todoIcon,
                        onTap: pressTodo,
                      )
                    : MainPageNavButton(
                        icon: todoIcon,
                        onTap: pressTodo,
                      ),
                (homeButtonPressed)
                    ? MainPageNavButtonTapped(
                        icon: homeIcon,
                        onTap: pressHome,
                      )
                    : MainPageNavButton(
                        icon: homeIcon,
                        onTap: pressHome,
                      ),
                (profileButtonPressed)
                    ? MainPageNavButtonTapped(
                        icon: profileIcon,
                        onTap: pressProfile,
                      )
                    : MainPageNavButton(
                        icon: profileIcon,
                        onTap: pressProfile,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
