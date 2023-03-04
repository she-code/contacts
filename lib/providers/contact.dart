import 'dart:convert';

import 'package:http/http.dart ' as http;
import 'package:flutter/material.dart';
import 'package:contacts/config/config.dart';
import 'package:contacts/models/contacts.dart';

class ContactProvider with ChangeNotifier {
  String _authToken;
  List<Contact> _contacts = [];

  List<Contact> get contacts {
    return [..._contacts];
  }

  ContactProvider(this._authToken, this._contacts);

  Future<void> createContact(
      String fname, String lname, String email, int phoneNo) async {
    try {
      final url = Uri.parse('${AppConstants.baseURl}/api/contacts/create');
      final response = await http.post(url,
          body: json.encode({
            'firstName': fname,
            'lastName': lname,
            'email': email,
            'phoneNo': phoneNo
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });

      final responseData = json.decode(response.body);
      // final data = responseData.contact;
      // Contact newContact = Contact(
      //     fname: data['firstName'],
      //     id: data['_id'],
      //     lname: data['lastName'],
      //     email: data['email'],
      //     phoneNo: data['phoneNo']);
      // _contacts.add(newContact);
      print({'create', responseData, _authToken});
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateContact(
      String fname, String lname, String email, int phoneNo, String id) async {
    try {
      final url = Uri.parse('${AppConstants.baseURl}/api/contacts/$id/update');
      final response = await http.patch(url,
          body: json.encode({
            'firstName': fname,
            'lastName': lname,
            'email': email,
            'phoneNo': (phoneNo)
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });

      final responseData = json.decode(response.body);
      print({'update', responseData});

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      final url = Uri.parse('${AppConstants.baseURl}/api/contacts/$id/delete');
      final response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });

      final responseData = json.decode(response.body);
      _contacts.removeWhere((element) => element.id == id);
      print({'delete', responseData, _contacts});
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getContacts() async {
    try {
      final url =
          Uri.parse('${AppConstants.baseURl}/api/contacts/getAllContacts');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final responseData = json.decode(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      ContactList contactList = ContactList.fromJson(data['contacts']);
      final List<Contact> contacts = contactList.contacts;

      _contacts = contacts;
      print({'contacts': data['contacts']});
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
