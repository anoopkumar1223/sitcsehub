import 'package:flutter/material.dart';
import 'package:sit_cse_hub/components/logo.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resource.color.backgroundColor,
      body: Center(
        child: Logo(),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'An Sitcse app',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
                color: Color(0xFF393636),
                fontFamily: 'Bangers',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
