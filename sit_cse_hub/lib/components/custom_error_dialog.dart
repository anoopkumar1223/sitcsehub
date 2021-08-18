import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomErrorDialog {
  static Future<dynamic> getErrorBox(var context, String msg) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              msg,
              style: TextStyle(
                fontFamily: Resource.string.lato,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Resource.color.primaryTheme,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    MyNavigation().pop(context: context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(
                      15,
                    ),
                    child: Text(
                      Resource.string.ok,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
