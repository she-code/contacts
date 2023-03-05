class User {
  String fname;
  String lname;
  String email;
  String password;
  int phoneNo;
  String id;
  User(
      {required this.fname,
      required this.id,
      required this.lname,
      required this.email,
      this.password: '',
      required this.phoneNo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        fname: json['firstName'],
        password: json['password'],
        lname: json['lastName']);
  }
}

class UserList {
  final List<User> users;
  UserList({
    required this.users,
  });
  factory UserList.fromJson(List<dynamic> parsedJson) {
    List<User> users = [];
    users = parsedJson.map((i) => User.fromJson(i)).toList();
    return new UserList(users: users);
  }
}
