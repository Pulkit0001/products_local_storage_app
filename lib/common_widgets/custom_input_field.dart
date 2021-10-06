

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key,  this.keyboardType = TextInputType.text, required this.label, required this.controller}) : super(key: key);

  final TextInputType keyboardType;
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(

        controller: controller,
        keyboardType: keyboardType ,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.amber, width: 2),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some value';
          }
          return null;
        },
      ),
    );
  }
}
