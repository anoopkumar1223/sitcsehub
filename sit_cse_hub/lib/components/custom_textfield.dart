import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:sit_cse_hub/resources/resource.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;
  final bool isObscure;
  final Function onFieldSubmitted;
  final Function onEditingComplete;
  final Function onSaved;
  final Function validator;

  CustomTextField({
    @required this.title,
    @required this.hintText,
    @required this.controller,
    @required this.keyboardType,
    this.onChanged,
    @required this.isObscure,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 17,
              fontFamily: Resource.string.lato,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ClayContainer(
          spread: 3,
          depth: 20,
          borderRadius: 50.0,
          color: Resource.color.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              onEditingComplete: (widget.onEditingComplete != null)
                  ? widget.onEditingComplete
                  : () {},
              onFieldSubmitted: (widget.onFieldSubmitted != null)
                  ? widget.onFieldSubmitted
                  : (value) {},
              onChanged:
                  (widget.onChanged != null) ? widget.onChanged : (value) {},
              onSaved: (widget.onSaved != null) ? widget.onSaved : (value) {},
              validator: (widget.validator != null)
                  ? widget.validator
                  : (a) {
                      return '';
                    },
              obscureText: (widget.isObscure == true) ? true : false,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
