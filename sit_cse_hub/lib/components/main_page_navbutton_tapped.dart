import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class MainPageNavButtonTapped extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  MainPageNavButtonTapped({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      curveType: CurveType.convex,
      color: Resource.color.mainPageButtonColor,
      depth: 50,
      spread: 5,
      borderRadius: 40,
      child: Padding(
        padding: EdgeInsets.all(
          12,
        ),
        child: Icon(
          icon,
          size: 25,
          color: Resource.color.mainPageButtonIconColor,
        ),
      ),
    );
  }
}
