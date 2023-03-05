import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatefulWidget {
  TextEditingController controller;
  FocusNode focusNode;
  FocusNode nextNode;
  String label;
  Icon icon;
  Function validatorFn;
  var data;
  CustomFormField(
      {required this.controller,
      required this.focusNode,
      required this.nextNode,
      required this.label,
      required this.icon,
      required this.validatorFn,
      required this.data});
  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: widget.icon,
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).errorColor, width: 1.w),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.w),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.lightGreenAccent.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: widget.label,
          // border: Border.all(color: Colors.black12,width:1.w),
        ),
        controller: widget.controller,
        validator: (value) {
          widget.validatorFn(value);
        },
        // (value) {
        //   if (!value!.contains('@')) {
        //     return 'Invalid lname address';
        //   }
        //   return null;
        // },
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
