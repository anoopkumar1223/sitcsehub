import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> options;
  final Function onChanged;
  final double width;
  final String selectedOption;
  final String title;
  final Function formValidator;

  CustomDropDown({@required this.options, @required this.onChanged, this.width, @required this.selectedOption, @required this.title, @required this.formValidator,});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 17,
            fontFamily: Resource.string.lato,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ClayContainer(
        width: (widget.width != null) ? widget.width : 30,
        spread: 3,
        depth: 20,
        borderRadius: 50.0,
        color: Resource.color.backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
            ),
            validator: widget.formValidator,
              hint: Text(Resource.string.select),
              dropdownColor: Resource.color.backgroundColor,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              style: TextStyle(
                color:  Resource.color.blackColor,
                fontSize: 18,
              ),
              value: widget.selectedOption,
              onChanged: widget.onChanged,
              items: widget.options.map((valueItem){
                return DropdownMenuItem(
                  value: valueItem,
                  child:Text(valueItem),
                );
              }).toList()
          ),
        ),
      ),
  ],
    );
  }
}
