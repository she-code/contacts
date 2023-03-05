import 'dart:async';
import 'dart:convert';
import 'package:contacts/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../common/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? userId;
  Timer? _authTimer;
  //Timer? _authTimer;
  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      print({"tok", _expiryDate});
    }
    return _token;
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    print(timeToExpiry);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
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
      print({
        'from autologin',
        extractedUserData['token'].toString(),
        {_token}
      });

      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    //_autoLogout();

    return true;
  }

  Future<void> register(String fname, String lname, String email,
      String password, int phoneNo) async {
    try {
      final url = Uri.parse('${AppConstants.baseURl}/api/users/register');
      final response = await http.post(url,
          body: json.encode({
            'firstName': fname,
            'lastName': lname,
            'email': email,
            'password': password,
            'phoneNo': phoneNo
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "accept": "application/json"
          });
      final reponseData = json.decode(response.body);

      if (reponseData['error'] != null) {
        print(reponseData['error']['message']);
        throw HttpException(reponseData['error']['message']);
      }
      _token = reponseData['token'];
      userId = reponseData['_id'].toString();
      final decodedjwt = json.decode(
          ascii.decode(base64.decode(base64.normalize(_token!.split(".")[1]))));
      _expiryDate = DateTime.now().add(Duration(seconds: decodedjwt['exp']));
      print({"_expir", _expiryDate});
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
      print(reponseData);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse('${AppConstants.baseURl}/api/users/login');

    try {
      final response = await http.post(url,
          body: json.encode(
            {"email": email, "password": password},
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "accept": "application/json"
          }
          //{"Accept": "application/json"},
          );
      final responseData = json.decode(response.body);
      // print({'body', responseData});
      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['token'];
      userId = responseData['_id'].toString();
      final decodedjwt = json.decode(
          ascii.decode(base64.decode(base64.normalize(_token!.split(".")[1]))));
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      print({'response', _expiryDate});
      print({"token", decodedjwt});

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
      // if (!prefs.containsKey('userData')) {
      //   return null;
      // }
      // _autoLogout();
      notifyListeners();
    } catch (e) {
      // TODO
      print(e);
      throw e;
    }
  }

  Future<void> getUserDetails() async {
    try {
      final url = Uri.parse('${AppConstants.baseURl}/api/users/me');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _token!
      });
      final responseData = json.encode(response.body);
      print(responseData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    _expiryDate = null;
    _token = null;
    userId = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    // clear to clear all , remove to remove specific
    prefs.remove('userData');
    print({"_token logout", _token});
    notifyListeners();
  }
}
