import 'package:flutter/material.dart';

class TextPasswordField extends StatefulWidget {
  final controller;
  final bool obscureText;
  final String labelText;
  final String Function(String) validator;
  TextPasswordField(
      {this.obscureText = true,
      this.labelText = "",
      this.controller,
      this.validator});
  @override
  _TextPasswordFieldState createState() => _TextPasswordFieldState();
}

class _TextPasswordFieldState extends State<TextPasswordField> {
  bool obscureText = true;
  IconData selectIconPassword() {
    return obscureText ? Icons.visibility_off : Icons.visibility;
  }

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: widget.labelText,
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(selectIconPassword()),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
                print('mudando tipo do texto');
              });
            },
          )),
    );
  }
}
