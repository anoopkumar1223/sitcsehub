import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sit_cse_hub/components/custom_notification_detail.dart';
import 'package:sit_cse_hub/components/notification_bean.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class NotificationComponent extends StatelessWidget {
  final NotificationBean notificationBean;

  const NotificationComponent({
    this.notificationBean,
  });

  @override
  Widget build(BuildContext context) {
    List<String> dateTime = notificationBean.dateTime.split('/');
    String date = dateTime[0];
    String time = dateTime[1];
    return GestureDetector(
      onTap: () {
        CustomNotificationDetail.getNotificationComponent(
          context,
          notificationBean.title,
          notificationBean.desc,
          notificationBean.attachmentUrl,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          gradient: LinearGradient(
            colors: Resource.color.royalBlue,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            children: [
              /*CircleAvatar(
                backgroundColor: Resource.color.whiteColor,
                radius: 40,
                child: Image.asset(
                  notificationBean.picUrl,
                ),
              ),
              SizedBox(
                width: 20,
              ),*/
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationBean.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Resource.color.whiteColor,
                        fontFamily: Resource.string.lato,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.chalkboardTeacher,
                          color: Resource.color.whiteColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          notificationBean.faculty,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Resource.color.whiteColor,
                            fontFamily: Resource.string.lato,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Resource.color.whiteColor,
                            fontFamily: Resource.string.lato,
                          ),
                        ),
                        Text(
                          time,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Resource.color.whiteColor,
                            fontFamily: Resource.string.lato,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
