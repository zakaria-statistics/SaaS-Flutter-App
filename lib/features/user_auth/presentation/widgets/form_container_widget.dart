import 'dart:js_interop';

import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const FormContainerWidget({super.key, 
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType
  });


  @override
  FormContainerWidgetState createState() => FormContainerWidgetState();
}

class FormContainerWidgetState extends State<FormContainerWidget> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        cursorWidth: 2,
        textAlign: TextAlign.start,
        style: const TextStyle(color: Colors.black, fontSize: 33.0),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100, // Set background color of the TextFormField
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 24.0),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,) : const Text(""),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 26.0),
        ),
      ),
    );
  }
}