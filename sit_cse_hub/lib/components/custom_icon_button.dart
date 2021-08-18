import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final IconData icon;
  final double iconSize;

  CustomIconButton({
    @required this.onPressed,
    @required this.borderRadius,
    @required this.horizontalPadding,
    @required this.verticalPadding,
    @required this.icon,
    @required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Resource.color.primaryTheme,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                borderRadius,
              ),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Icon(
          icon,
          color: Resource.color.whiteColor,
          size: iconSize,
        ),
      ),
    );
  }
}
