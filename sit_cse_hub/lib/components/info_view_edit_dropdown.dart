import 'dart:io';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sit_cse_hub/components/custom_text_button.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/services/firebase_services/firebase_storage_service.dart';
import 'package:sit_cse_hub/services/firebase_services/firestore_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_error_dialog.dart';
import 'package:path/path.dart';
import 'custom_loader.dart';

class InfoDropDown extends StatefulWidget {
  final String title;
  final InfoType type;

  InfoDropDown({
    @required this.title,
    @required this.type,
  });
  @override
  _InfoDropDownState createState() => _InfoDropDownState();
}

class _InfoDropDownState extends State<InfoDropDown> {
  bool open = false;
  File file;
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
    List info = widget.title.split(" ");
    String year = info[0];
    String section = info[1];
    return ClayContainer(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextButton(
                                  title: 'Open',
                                  onPressed: () async {
                                    List<String> yearSec =
                                        widget.title.split(' ');
                                    String url = (widget.type ==
                                            InfoType.TIMETABLE)
                                        ? await Database.getTimeTable(
                                            yearSec[0],
                                            yearSec[1],
                                          )
                                        : await Database.getSchemeAndSyllabus(
                                            widget.title);
                                    if (url == null || url == "")
                                      CustomErrorDialog.getErrorBox(
                                        context,
                                        (widget.type == InfoType.TIMETABLE)
                                            ? 'Timetable for ${widget.title} is not uploaded yet. Please upload it'
                                            : 'Scheme and Syllabus for ${widget.title} year is not uploaded yet. Please upload it',
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
                      (file != null) ? basename(file.path) : 'No file selected',
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextButton(
                          title: 'Upload',
                          onPressed: () async {
                            CustomLoader.getLoader(context);
                            if (file != null) {
                              final s = await MyFirebaseStorage.uploadFile(
                                (widget.type == InfoType.SYLLABUS)
                                    ? 'scheme_and_syllabus/$year$section/${basename(file.path)}'
                                    : 'timetable/$year/${basename(file.path)}',
                                file,
                              );
                              setState(() {
                                attachmentUrl = s;
                              });
                            }
                            (widget.type == InfoType.SYLLABUS)
                                ? Database.addScheme(
                                    attachmentUrl, context, year, section)
                                : Database.addTimeTable(
                                    attachmentUrl, context, year, section);
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
    );
  }
}
