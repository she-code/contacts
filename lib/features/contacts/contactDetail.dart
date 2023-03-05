import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key});
  static String routeName = '/contactDetails';
  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  String? contactId;
  var _isinit = true;
  var _isLoading = false;
  var _contact;
  void didChangeDependencies() {
    contactId = ModalRoute.of(context)?.settings.arguments as String;

    if (_isinit) {
      setState(() {
        _isLoading = true;
      });

      _contact = Provider.of<ContactProvider>(context, listen: false)
          .getContactDetail(contactId!);

      _isinit = false;
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<ContactProvider>(context, listen: false)
        .findByID(contactId!);
    print(contact);
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [Text('ContactDetails'), Text(contact.fname)],
              ))),
    );
  }
}
