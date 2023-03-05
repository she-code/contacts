import 'package:basic_utils/basic_utils.dart';
import 'package:contacts/features/contacts/widgets/contactInfoCard.dart';
import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final name =
        '${StringUtils.capitalize(contact.fname)} ${StringUtils.capitalize(contact.lname)}';
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    height: 70,
                    alignment: Alignment.center,
                    child: CircleAvatar(radius: 30, child: Icon(Icons.camera)),
                  ),
                  ContactInfo(
                      name,
                      const Icon(
                        Icons.person,
                        color: Colors.purple,
                      )),
                  ContactInfo(contact.phoneNo.toString(),
                      const Icon(Icons.phone, color: Colors.purple)),
                  ContactInfo(contact.email,
                      const Icon(Icons.email, color: Colors.purple)),
                  ContactInfo(contact.note,
                      const Icon(Icons.note, color: Colors.purple)),
                ],
              ))),
      bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.purple),
          unselectedItemColor: Colors.purple,
          backgroundColor: Colors.purple,
          fixedColor: Colors.purple,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.share,
                  color: Colors.purple,
                ),
                label: 'Share'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Edit'),
            BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete')
          ]),
    );
  }
}
