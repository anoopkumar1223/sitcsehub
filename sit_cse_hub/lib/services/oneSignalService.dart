import 'package:http/http.dart';
import 'dart:convert';
import 'package:sit_cse_hub/resources/resource.dart';

Future<Response> sendNotification(
    List<String> tokenIdList, String contents, String heading) async {
  return await post(
    Uri.parse('https://onesignal.com/api/v1/notifications'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "app_id": Resource.constant
          .oneSignalAppId, //kAppId is the App Id that one get from the OneSignal When the application is registered.

      "include_player_ids":
          tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

      // android_accent_color reprsent the color of the heading text in the notifiction
      "android_accent_color": "FF6886c5",

      "small_icon": "ic_stat_onesignal_default",

      "large_icon":
          'https://firebasestorage.googleapis.com/v0/b/sit-cse-hub.appspot.com/o/logo%2Flogo.jpg?alt=media&token=800646db-1123-4960-97c5-2cbf6240968c',

      "headings": {"en": heading},

      "contents": {"en": contents},
    }),
  );
}
