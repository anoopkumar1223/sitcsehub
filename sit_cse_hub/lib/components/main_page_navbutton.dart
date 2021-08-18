import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class MainPageNavButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  MainPageNavButton({
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClayContainer(
        color: Resource.color.mainPageButtonColor,
        depth: 100,
        spread: 2,
        borderRadius: 40,
        child: Padding(
          padding: const EdgeInsets.all(
            12,
          ),
          child: Icon(
            icon,
            size: 25,
            color: Resource.color.mainPageButtonIconColor,
          ),
        ),
      ),
    );
  }
}
