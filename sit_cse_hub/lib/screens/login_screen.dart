import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/components/custom_loader.dart';
import 'package:sit_cse_hub/components/custom_text_button.dart';
import 'package:sit_cse_hub/components/custom_textfield.dart';
import 'package:sit_cse_hub/resources/constant.dart';
import 'package:sit_cse_hub/resources/resource.dart';
import 'package:sit_cse_hub/resources/route.dart';
import 'package:sit_cse_hub/services/firebase_services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final UserType userType;

  LoginScreen({@required this.userType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  FocusNode node = FocusNode();
  Future<UserCredential> userCredential;

  Function emailValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
    return null;
  };

  Function passwordValidator = (String value) {
    if (value.isEmpty) return Resource.string.required;
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
                      Resource.string.loginAccount,
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontFamily: Resource.string.bangers,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              Resource.string.welcome,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: Resource.string.lato,
                              ),
                            ),
                            Text(
                              Resource.string.login,
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: Resource.string.lato,
                              ),
                            ),
                          ],
                        ),
                        Lottie.asset(
                          Resource.image.loginGif,
                          height: 250,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          title: Resource.string.email,
                          hintText: (widget.userType == UserType.STUDENT)
                              ? 'usn@sit.ac.in'
                              : 'email',
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          validator: emailValidator,
                          onSaved: (value) {
                            email = value;
                          },
                          isObscure: false,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          title: Resource.string.password,
                          hintText: Resource.string.maskedPassword,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          validator: passwordValidator,
                          onSaved: (value) {
                            password = value;
                          },
                          isObscure: true,
                          onFieldSubmitted: (a) =>
                              FocusScope.of(context).unfocus(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              String email;
                              TextEditingController controller =
                                  TextEditingController();
                              getEmailRequester(
                                title: 'Request password reset',
                                hintText: (widget.userType == UserType.STUDENT)
                                    ? 'usn@sit.ac.in'
                                    : 'email',
                                controller: controller,
                                context: context,
                                textFieldTitle: 'Email',
                                onChanged: (value) {
                                  email = value;
                                },
                                onPressed: () {
                                  CustomLoader.getLoader(context);
                                  MyAuthService.passwordReset(context, email);
                                },
                              );
                            },
                            child: Text(
                              Resource.string.forgotPassword,
                              style: TextStyle(
                                fontFamily: Resource.string.lato,
                                color: Resource.color.primaryTheme,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextButton(
                          title: Resource.string.login,
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            CustomLoader.getLoader(context);
                            if (widget.userType == UserType.STUDENT)
                              MyAuthService.signIn(email, password, context);
                            else
                              MyAuthService.professorSignIn(
                                  email, password, context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  (widget.userType == UserType.STUDENT)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Resource.string.noAccount,
                              style: TextStyle(
                                fontFamily: Resource.string.lato,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                Resource.navigation.pushReplacement(
                                  context: context,
                                  screen: MyRoute.signupScreen,
                                );
                              },
                              child: Text(
                                Resource.string.signUp,
                                style: TextStyle(
                                  color: Resource.color.primaryTheme,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontFamily: Resource.string.lato,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getEmailRequester({
  BuildContext context,
  String title,
  String textFieldTitle,
  String hintText,
  TextEditingController controller,
  Function onFieldSubmitted,
  Function onChanged,
  Function onPressed,
}) {
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
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  title: textFieldTitle,
                  hintText: hintText,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  isObscure: false,
                  onFieldSubmitted: (a) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: onChanged,
                ),
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
                  onPressed: onPressed,
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
