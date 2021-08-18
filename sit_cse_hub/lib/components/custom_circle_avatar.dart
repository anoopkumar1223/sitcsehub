import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final String imagePath;
  final Function onPressed;

  CustomCircleAvatar({
    @required this.radius,
    @required this.imagePath,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: Resource.color.primaryTheme,
        radius: radius,
        child: Padding(
          padding: EdgeInsets.all(
            10.0,
          ),
          child: Lottie.asset(
            imagePath,
          ),
        ),
      ),
    );
  }
}
