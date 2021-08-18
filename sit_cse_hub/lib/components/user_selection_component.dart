import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class UserSelectionComponent extends StatefulWidget {
  final String title;
  final String image;
  final Function onTap;
  final double width;

  const UserSelectionComponent({
    @required this.title,
    @required this.image,
    @required this.onTap,
    @required this.width,
  });

  @override
  _UserSelectionComponentState createState() => _UserSelectionComponentState();
}

class _UserSelectionComponentState extends State<UserSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Resource.color.borderColor,
            width: widget.width,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
          color: Resource.color.primaryTheme,
        ),
        child: Row(
          children: <Widget>[
            Lottie.asset(
              widget.image,
              height: 200,
              width: 200,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontFamily: Resource.string.lato,
                letterSpacing: 2,
                color: Resource.color.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
