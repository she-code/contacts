import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  TextEditingController controller;
  FocusNode focusNode;
  FocusNode nextNode;
  String label;
  var data;
  CustomFormField(
      {required this.controller,
      required this.focusNode,
      required this.nextNode,
      required this.label,
      required this.data});
  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        keyboardType: TextInputType.number,
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: const Icon(
            Icons.person,
            // color: iconColor,
            size: 20,
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).errorColor, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.lightGreenAccent.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: widget.label,
          // border: Border.all(color: Colors.black12,width: 2),
        ),
        controller: widget.controller,
        validator: (value) {
          // if (!value!.contains('@')) {
          //   return 'Invalid lname address';
          // }
          return null;
        },
        onSaved: (value) {
          // _authData['phone'] = value!;
          widget.data = value!;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.nextNode);
        },
      ),
    );
  }
}
