import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionBtn extends StatelessWidget {
  String label;
  VoidCallback fn;

  ActionBtn(this.label, this.fn);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      //padding: EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: fn,
        style: ElevatedButton.styleFrom(
          elevation: 15,
          minimumSize: Size.fromHeight(50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      ),
    );
  }
}
