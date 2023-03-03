import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});
  static String routeName = '/contactDetails';
  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text('ContactDetails')),
    );
  }
}
