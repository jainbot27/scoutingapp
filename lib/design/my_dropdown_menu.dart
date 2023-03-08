import 'package:flutter/material.dart';

class MyDropdownMenu extends StatefulWidget {
  final List<String> list;
  MyDropdownMenu({Key? key, required this.list}) : super(key: key);
  // ignore: library_private_types_in_public_api
  final _MyDropdownMenuState test = _MyDropdownMenuState();

  String getCurrentValue() {
    return test.currentValue;
  }

  @override
  // ignore: no_logic_in_create_state
  State<MyDropdownMenu> createState() => test;
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  late String currentValue = "";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue.isNotEmpty ? currentValue : null,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.greenAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          currentValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
