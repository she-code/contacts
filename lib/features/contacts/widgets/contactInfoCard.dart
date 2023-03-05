import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactInfo extends StatelessWidget {
  String data;
  Icon icon;
  ContactInfo(this.data, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        // height: 60,
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(color: Color.fromARGB(255, 229, 170, 239)),
        child: Row(
          children: [
            Container(margin: EdgeInsets.only(right: 35), child: icon),
            Text(
              StringUtils.capitalize(data),
              style: TextStyle(fontSize: 15.sp),
            ),
          ],
        ));
  }
}
