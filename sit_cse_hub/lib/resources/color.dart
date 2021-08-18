import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class MyColor {
  //General
  Color get backgroundColor => Color(0xFFECF0F3);
  Color get whiteColor => Colors.white;
  Color get blackColor => Colors.black;
  Color get blueGrey => Colors.blueGrey;
  Color get primaryTheme => Color(0XFf6886c5);

  //Tell us who you are screen
  Color get borderColor => Colors.black38;

  //Splash screen
  Color get splashComponentsColor => Color(0xFF393636);

  //Main screen
  Color get mainPageButtonColor => Color(0xFFECF0F3);
  Color get bottomNavBarColor => Color(0xFFECF3F9);
  Color get mainPageButtonIconColor => Colors.grey[800];

  //Home screen
  List<Color> get royalBlue => GradientColors.royalBlue;
  List<Color> get coolblues => GradientColors.coolBlues;
  List<Color> get purplePink => GradientColors.purplePink;
  List<Color> get fbMessenger => GradientColors.facebookMessenger;
  List<Color> get seaBlue => GradientColors.seaBlue;
}
