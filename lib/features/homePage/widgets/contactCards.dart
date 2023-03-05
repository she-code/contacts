import 'package:contacts/features/contacts/contactDetail.dart';
import 'package:contacts/features/homePage/home.dart';
import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ContactCards extends StatefulWidget {
  String id;
  String fname;
  String lname;
  String email;
  int phoneNo;
  ContactCards(this.id, this.fname, this.lname, this.email, this.phoneNo);

  @override
  State<ContactCards> createState() => _ContactCardsState();
}

class _ContactCardsState extends State<ContactCards> {
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  final Map<String, dynamic> _contactData = {
    'fname': '',
    'lname': '',
    'email': '',
    'phoneNo': 0
  };
  Future deleteContact() async {
    print("delete");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Contact will be deleted"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
              onPressed: () async {
                await Provider.of<ContactProvider>(context, listen: false)
                    .deleteContact(widget.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Contact deleted")));

                Navigator.of(ctx).pop();
              },
              child: const Text('Delete')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }

  Future updateContact() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Update Contact"),
        content: SingleChildScrollView(
          child: SizedBox(
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "First Name",
                      ),
                      controller: fnameController..text = widget.fname,
                      onSaved: (newValue) {
                        _contactData['fname'] = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                      ),
                      controller: lnameController..text = widget.lname,
                      onSaved: (newValue) {
                        _contactData['lname'] = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      controller: emailController..text = widget.email,
                      onSaved: (newValue) {
                        _contactData['email'] = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Phone",
                      ),
                      controller: phoneController
                        ..text = widget.phoneNo.toString(),
                      onSaved: (newValue) {
                        _contactData['phoneNo'] = newValue!;
                      },
                    )
                  ],
                )),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await Provider.of<ContactProvider>(context, listen: false)
                    .updateContact(
                        fnameController.text,
                        lnameController.text,
                        emailController.text,
                        int.parse(phoneController.text),
                        widget.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Press updated")));
                print(fnameController.text);

                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacementNamed(Home.routeName);
              },
              child: const Text('Update')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ContactDetails.routeName, arguments: widget.id),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.only(bottom: 7),
            height: 80,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(widget.fname),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: deleteContact,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: updateContact,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            )));
  }
}
