import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactCards extends StatelessWidget {
  const ContactCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ListTile(
      title: Text('Frehiwot'),
      leading: CircleAvatar(child: Icon(Icons.person)),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.delete,
              color: Colors.red,
            ),
            Icon(
              Icons.edit,
              color: Colors.green,
            )
          ],
        ),
      ),
    ));
  }
}
