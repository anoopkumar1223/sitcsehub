import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'TODO',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
