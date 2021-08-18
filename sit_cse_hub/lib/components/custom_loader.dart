import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomLoader {
  static Future<dynamic> getLoader(var context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              Resource.string.loading,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SpinKitFadingCircle(
                  color: Resource.color.primaryTheme,
                  size: 50.0,
                ),
              ],
            ),
          );
        });
  }
}
