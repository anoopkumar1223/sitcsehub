import 'package:flutter/material.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomNotificationDetail {
  static Future<dynamic> getNotificationComponent(
      var context, String title, String desc, String attachmentUrl) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: Resource.string.lato,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    desc,
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 18,
                      fontFamily: Resource.string.lato,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (attachmentUrl == null || attachmentUrl == "")
                        CustomErrorDialog.getErrorBox(
                          context,
                          'No attachment',
                        );
                      else
                        await launch(attachmentUrl);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf_outlined,
                          color: Resource.color.primaryTheme,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Attachment',
                          style: TextStyle(
                            color: Resource.color.primaryTheme,
                            fontWeight: FontWeight.bold,
                            fontFamily: Resource.string.lato,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
            ),
          );
        });
  }
}
