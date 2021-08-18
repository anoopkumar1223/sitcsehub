import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class HomePageOption extends StatelessWidget {
  final IconData icon;
  final List<Color> color;
  final String title;
  final Function onTap;

  HomePageOption({this.icon, this.color, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          gradient: LinearGradient(
            colors: color,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 25,
                color: Resource.color.whiteColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Resource.color.whiteColor,
                  fontFamily: Resource.string.lato,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
