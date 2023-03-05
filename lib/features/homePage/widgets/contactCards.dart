import 'package:basic_utils/basic_utils.dart';
import 'package:contacts/features/contacts/contactDetail.dart';
import 'package:contacts/features/homePage/home.dart';
import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ContactCards extends StatefulWidget {
  String id;
  String fname;
  String lname;
  String email;
  String note;
  int phoneNo;
  ContactCards(
      this.id, this.fname, this.lname, this.email, this.note, this.phoneNo);

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
                    const SnackBar(content: Text("Contact Deleted")));

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
                    const SnackBar(content: Text("Contact Updated")));
                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacementNamed(Home.routeName);
              },
              child: const Text('UPDATE')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('CANCEL'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              key: ValueKey(widget.id),
              onPressed: (_) {
                deleteContact();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: (_) {
                updateContact();
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
            ),
          ],
        ),
        child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(ContactDetails.routeName, arguments: widget.id),
            child: Container(
                margin: EdgeInsets.only(bottom: 7),
                //  height: 80,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          radius: 22,
                          child:
                              Text(widget.fname.substring(0, 1).toUpperCase())),
                      title: Text(
                        '${StringUtils.capitalize(widget.fname)} ${StringUtils.capitalize(widget.lname)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(StringUtils.capitalize(widget.note)),
                      trailing: Icon(Icons.star_border_outlined),
                    ),
                    const Divider(
                      color: Colors.grey,
                    )
                  ],
                ))));
  }
}
