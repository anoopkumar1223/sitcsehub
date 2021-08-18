import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  CustomTextButton({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Resource.color.primaryTheme,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: Resource.string.lato,
              fontSize: 17,
              color: Resource.color.backgroundColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
