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
        content: Text("Are you sure?"),
        actions: [
          TextButton(
              onPressed: () async {
                await Provider.of<ContactProvider>(context, listen: false)
                    .deleteContact(widget.id);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Contact deleted")));

                Navigator.of(ctx).pop();
              },
              child: Text('Delete')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }

  Future updateContact() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Update Press"),
        content: SizedBox(
          height: 250,
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Press updated")));
                print(fnameController.text);

                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacementNamed(Home.routeName);
              },
              child: Text('Update')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ListTile(
      title: Text(widget.fname),
      leading: CircleAvatar(child: Icon(Icons.person)),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                // onPressed: () async {
                //   await Provider.of<ContactProvider>(context)
                //       .updateContact(fname, lname, email, phoneNo, id);
                // },
                onPressed: deleteContact,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: updateContact,
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    ));
  }
}
