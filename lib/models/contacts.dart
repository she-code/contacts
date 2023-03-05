class Contact {
  String fname;
  String lname;
  String email;
  String note;
  int phoneNo;
  String id;
  Contact(
      {required this.fname,
      required this.id,
      required this.lname,
      required this.email,
      required this.note,
      required this.phoneNo});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['_id'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        fname: json['firstName'],
        note: json['note'],
        lname: json['lastName']);
  }
}

class ContactList {
  final List<Contact> contacts;
  ContactList({
    required this.contacts,
  });
  factory ContactList.fromJson(List<dynamic> parsedJson) {
    List<Contact> contacts = [];
    contacts = parsedJson.map((i) => Contact.fromJson(i)).toList();
    return new ContactList(contacts: contacts);
  }
}
