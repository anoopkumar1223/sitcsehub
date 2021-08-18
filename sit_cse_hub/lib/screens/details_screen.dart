import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/custom_circle_avatar.dart';
import 'package:sit_cse_hub/components/custom_dropdown.dart';
import 'package:sit_cse_hub/components/custom_icon_button.dart';
import 'package:sit_cse_hub/components/custom_loader.dart';
import 'package:sit_cse_hub/components/custom_text_button.dart';
import 'package:sit_cse_hub/resources/navigation.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/components/custom_textfield.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/services/firebase_services/firestore_service.dart';
import 'package:sit_cse_hub/services/sharedPreferences/sharedPreferenceService.dart';

class DetailsScreen extends StatefulWidget {
  final String email;

  DetailsScreen({
    @required this.email,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController nameController;
  TextEditingController usnController;
  TextEditingController yearController;
  TextEditingController phoneController;
  String firstName;
  String lastName;
  String usn;
  String phone;
  String year;
  String section;
  List<String> yearList = ['I', 'II', 'III', 'IV'];
  List<String> sectionList = ['A', 'B', 'C'];
  String profile = 'assets/images/profile_boy.json';
  final _formKey = GlobalKey<FormState>();
  FocusNode node = FocusNode();

  Function firstNameValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
    return null;
  };

  Function lastNameValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
    return null;
  };

  Function usnValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
    return null;
  };

  Function phoneValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
    if (value.length != 10) return 'Please enter a valid phone number';
    return null;
  };

  Function yearFormValidator = (String value) {
    if (value == null) return Resource.string.required;
    return null;
  };

  Function sectionFormValidator = (String value) {
    if (value == null) return Resource.string.required;
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(node);
      },
      child: Scaffold(
        backgroundColor: Resource.color.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      Resource.string.tellUsABit,
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontFamily: Resource.string.bangers,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            Resource.string.enterYour,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: Resource.string.lato,
                            ),
                          ),
                          Text(
                            Resource.string.details,
                            style: TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: Resource.string.lato,
                            ),
                          ),
                        ],
                      ),
                      Lottie.asset(
                        Resource.image.detailsGif,
                        height: 250,
                        width: 200,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Text(
                      'Profile image',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: Resource.string.lato,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClayContainer(
                    spread: 3,
                    depth: 20,
                    borderRadius: 50.0,
                    color: Resource.color.backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: CustomCircleAvatar(
                            radius: 60,
                            imagePath: profile,
                            onPressed: () {},
                          ),
                        ),
                        CustomIconButton(
                          onPressed: () {
                            getProfilePics(context);
                          },
                          borderRadius: 50,
                          horizontalPadding: 15,
                          verticalPadding: 10,
                          icon: Icons.add,
                          iconSize: 40,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          title: Resource.string.firstName,
                          hintText: Resource.string.john,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: firstNameValidator,
                          onSaved: (value) {
                            firstName = value;
                          },
                          isObscure: false,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          title: Resource.string.lastName,
                          hintText: Resource.string.ca,
                          keyboardType: TextInputType.text,
                          controller: yearController,
                          validator: lastNameValidator,
                          onSaved: (value) {
                            lastName = value;
                          },
                          isObscure: false,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          title: Resource.string.detailsUsn,
                          hintText: Resource.string.john1,
                          keyboardType: TextInputType.text,
                          controller: usnController,
                          validator: usnValidator,
                          onSaved: (value) {
                            usn = value;
                          },
                          isObscure: false,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          title: Resource.string.num,
                          hintText: Resource.string.phoneNum,
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          validator: phoneValidator,
                          onSaved: (value) {
                            phone = value;
                          },
                          isObscure: false,
                          onFieldSubmitted: (a) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomDropDown(
                              title: 'Year',
                              options: yearList,
                              selectedOption: year,
                              onChanged: (newValue1) {
                                setState(() {
                                  year = newValue1;
                                });
                              },
                              width: MediaQuery.of(context).size.width / 2.2,
                              formValidator: yearFormValidator,
                            ),
                            CustomDropDown(
                              title: 'Section',
                              options: sectionList,
                              selectedOption: section,
                              onChanged: (newValue1) {
                                setState(() {
                                  section = newValue1;
                                });
                              },
                              width: MediaQuery.of(context).size.width / 2.2,
                              formValidator: sectionFormValidator,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextButton(
                          title: Resource.string.submit,
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            CustomLoader.getLoader(context);
                            Database.addStudentData(
                              fName: firstName,
                              lName: lastName,
                              usn: usn,
                              phone: phone,
                              email: widget.email,
                              year: year,
                              section: section,
                              pic: profile,
                              context: context,
                            );
                            MySharedPreference.addStudentData(
                              fName: firstName,
                              email: widget.email,
                              year: year,
                              section: section,
                              pic: profile,
                            );
                            MyNavigation().pop(context: context);
                            MyNavigation().pushReplacement(
                              context: context,
                              screen: MyRoute.mainScreen,
                            );
                            MySharedPreference.preferences
                                .setInt('screenFlag', 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> getProfilePics(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              'Select your profile image',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCircleAvatar(
                        radius: 60,
                        imagePath: 'assets/images/profile_boy.json',
                        onPressed: () {
                          setState(() {
                            profile = 'assets/images/profile_boy.json';
                          });
                          MyNavigation().pop(context: context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomCircleAvatar(
                        radius: 60,
                        imagePath: 'assets/images/profile_girl.json',
                        onPressed: () {
                          setState(() {
                            profile = 'assets/images/profile_girl.json';
                          });
                          MyNavigation().pop(context: context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomCircleAvatar(
                        radius: 60,
                        imagePath: 'assets/images/profile_boy_with_laptop.json',
                        onPressed: () {
                          setState(() {
                            profile =
                                'assets/images/profile_boy_with_laptop.json';
                          });
                          MyNavigation().pop(context: context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomCircleAvatar(
                        radius: 60,
                        imagePath:
                            'assets/images/profile_girl_with_laptop.json',
                        onPressed: () {
                          setState(() {
                            profile =
                                'assets/images/profile_girl_with_laptop.json';
                          });
                          MyNavigation().pop(context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
