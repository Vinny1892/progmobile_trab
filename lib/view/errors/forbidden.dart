import 'package:flutter/material.dart';

class ForbiddenPage extends StatelessWidget {
  final String message;

  ForbiddenPage({this.message});
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Forbidden Page"),
    );
  }
}
