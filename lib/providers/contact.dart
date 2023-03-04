import 'package:contacts/models/contacts.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider with ChangeNotifier {
  String _authToken;
  List<Contact> contacts = [];

  List<Contact> get presses {
    return [...contacts];
  }

  ContactProvider(this._authToken, this.contacts);
}
