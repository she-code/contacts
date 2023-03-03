import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? userId;

  //Timer? _authTimer;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      print({"tok", _token});
      return _token;
    }
    return null;
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        print("No token stored");
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'].toString());
      if (expiryDate.isBefore(DateTime.now())) {
        print("expired");
        return false;
      }
      _token = extractedUserData['token'].toString();
      userId = extractedUserData['userId'].toString();

      // print({_token});
      print({extractedUserData});

      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    // _authoLogout();

    return true;
  }
}
