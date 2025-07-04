import 'package:flutter/material.dart';

class Input extends StatelessWidget {
   Input({
    super.key,
    required TextEditingController controller,
    required this.name,
    required this.type
  }) : _controller1 = controller;

  TextInputType type;
  String name;
  

  final TextEditingController _controller1;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller1,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: Colors.blue,
          )
        )
      ),
    );
  }
}