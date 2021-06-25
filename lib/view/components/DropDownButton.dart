import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key key, this.items}) : super(key: key);
  final List<String> items;
  @override
  _DropDownButtonState createState() => _DropDownButtonState(items: items);
}

class _DropDownButtonState extends State<DropDownButton> {
  _DropDownButtonState({this.items});
  List<String> items = [];
  String value;

  initState() {
    super.initState();
    value = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          value = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
