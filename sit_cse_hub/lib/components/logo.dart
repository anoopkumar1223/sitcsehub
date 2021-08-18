import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      curveType: CurveType.convex,
      color: Resource.color.backgroundColor,
      height: 220,
      width: 220,
      borderRadius: 50,
      spread: 5,
      depth: 50,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(
            20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 47,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.laptop_mac,
                      size: 75,
                      color: Resource.color.splashComponentsColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 13,
                      ),
                      child: Icon(
                        FontAwesomeIcons.coffee,
                        color: Resource.color.splashComponentsColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '<SITCSE-HUB/>',
                style: TextStyle(
                  fontFamily: 'Bangers',
                  color: Resource.color.splashComponentsColor,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
