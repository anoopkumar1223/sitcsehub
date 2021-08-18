import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/custom_error_dialog.dart';
import 'package:sit_cse_hub/components/custom_loader.dart';
import 'package:sit_cse_hub/components/custom_text_button.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/services/firebase_services/firebase_storage_service.dart';
import 'package:sit_cse_hub/services/firebase_services/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';

class CalendarOfEventsScreen extends StatefulWidget {
  @override
  _CalendarOfEventsScreenState createState() => _CalendarOfEventsScreenState();
}

class _CalendarOfEventsScreenState extends State<CalendarOfEventsScreen> {
  File file;
  bool open = false;
  String attachmentUrl;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Resource.color.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Resource.color.blackColor,
        ),
        backgroundColor: Resource.color.backgroundColor,
        centerTitle: true,
        title: Text(
          Resource.string.calendarOfEvents,
          style: TextStyle(
            color: Resource.color.blackColor,
            letterSpacing: 5,
            fontFamily: Resource.string.bangers,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            15,
            30,
            15,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                'assets/images/profile_girl_with_laptop.json',
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              ClayContainer(
                spread: 3,
                depth: 20,
                borderRadius: 50.0,
                color: Resource.color.backgroundColor,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 5,
                    ),
                    child: (file == null)
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Resource.string.calendarOfEvents,
                                    style: TextStyle(
                                      fontFamily: Resource.string.lato,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        open = !open;
                                      });
                                    },
                                    child: Icon(
                                      (open == false)
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      size: 40,
                                      color: Resource.color.primaryTheme,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              (open == true)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTextButton(
                                            title: 'Open',
                                            onPressed: () async {
                                              String url = await Database
                                                  .getCalendarOfEvents();
                                              if (url == null || url == "")
                                                CustomErrorDialog.getErrorBox(
                                                  context,
                                                  'Calendar of events is not uploaded yet. Please update it',
                                                );
                                              else
                                                await launch(url);
                                            },
                                          ),
                                          CustomTextButton(
                                            title: 'Update',
                                            onPressed: selectFile,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                (file != null)
                                    ? basename(file.path)
                                    : 'No file selected',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Resource.color.primaryTheme,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Resource.string.lato,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextButton(
                                    title: 'Upload',
                                    onPressed: () async {
                                      CustomLoader.getLoader(context);
                                      if (file != null) {
                                        final s =
                                            await MyFirebaseStorage.uploadFile(
                                          'Calander_of_events/${basename(file.path)}',
                                          file,
                                        );
                                        setState(() {
                                          attachmentUrl = s;
                                        });
                                      }
                                      Database.addCalendarOfEvents(
                                        attachmentUrl,
                                        context,
                                      );
                                      MyNavigation().pop(context: context);
                                      CustomErrorDialog.getErrorBox(
                                        context,
                                        'Uploaded successfully',
                                      );
                                      setState(() {
                                        file = null;
                                      });
                                    },
                                  ),
                                  CustomTextButton(
                                    title: 'Cancel',
                                    onPressed: () {
                                      setState(() {
                                        file = null;
                                      });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
