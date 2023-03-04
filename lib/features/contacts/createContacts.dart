import 'package:contacts/common/errorMsg.dart';
import 'package:contacts/common/fieldGap.dart';
import 'package:contacts/common/textfield/formTextField.dart';
import 'package:contacts/features/Auth/screens/login.dart';
import 'package:contacts/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../common/http_exception.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({super.key});
  static String routeName = '/CreateContact';
  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode _fnameFocusNode = FocusNode();
  FocusNode _lnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  var _isLoading = false;
  var passVisible = false;
  final GlobalKey<FormState> _form = GlobalKey();
  final Map<String, dynamic> _authData = {
    'fname': '',
    'lname': '',
    'phoneNo': 0,
    'email': '',
  };
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _lnameFocusNode.dispose();
    _fnameFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  Future submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print({_authData});
      await Provider.of<Auth>(context, listen: false).register(
          _authData['fname'].toString(),
          _authData['lname'].toString(),
          _authData['email'].toString(),
          _authData['password'].toString(),
          int.parse(_authData['phoneNo']));
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      switch (e.toString()) {
        case "Email already registered":
          errorMessage = "Email already registered";
          break;
        case "User not found":
          errorMessage = "User not found";
          break;
        case "Invalid email or password":
          errorMessage = "Invalid email or password";
          break;
        default:
          errorMessage = 'Authentication failed';
          break;
      }
      ErrorMsg().showErrorDialog(errorMessage, context);
    } catch (e) {
      print({e.toString()});
      const errorMessage = "Couldn't authenticate please try again";
      ErrorMsg().showErrorDialog(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80),
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/auth.png',
                        fit: BoxFit.cover, width: 150),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ('Register'.toUpperCase()),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _form,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _fnameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  // color: iconColor,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "First Name",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: fnameController,
                              validator: (value) {
                                if (value!.length < 2) {
                                  return 'First name must atleast contain 2 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['fname'] = value!;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_lnameFocusNode);
                              },
                            ),
                          ),
                          FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _lnameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  // color: iconColor,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "Last Name",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: lnameController,
                              validator: (value) {
                                // if (!value!.contains('@')) {
                                //   return 'Invalid lname address';
                                // }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['lname'] = value!;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                          ),
                          FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              focusNode: _phoneFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  // color: iconColor,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "Phone",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: phoneController,
                              validator: (value) {
                                if (value!.length < 10) {
                                  return 'Phone number cant be less than 10 charachters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['phoneNo'] = value!;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocusNode);
                              },
                            ),
                          ),
                          // CustomFormField(
                          //     controller: phoneController,
                          //     focusNode: _phoneFocusNode,
                          //     nextNode: _emailFocusNode,
                          //     label: 'Phone',
                          //     data: _authData['phoneNo']),
                          FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  // color: iconColor,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "Email",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: emailController,
                              validator: (value) {
                                if (!value!.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                          ),
                          FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: passVisible ? true : false,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.purpleAccent,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passVisible = !passVisible;
                                      });
                                    },
                                    icon: passVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "Password",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: passwordController,
                              validator: (value) {
                                if (value!.length < 8) {
                                  return 'Password must atleast have 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                              // onFieldSubmitted: (_) {
                              //   FocusScope.of(context)
                              //       .requestFocus(_passwordFocusNode);
                              // },
                            ),
                          ),
                          FieldGap(),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            Container(
                              width: 400,
                              // padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(
                                child: Text(
                                  "Create".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: submit,
                                //     () {
                                //   Navigator.of(context)
                                //       .pushReplacementNamed(MainPage.routeName);
                                // },
                                style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shadowColor: Colors.green,
                                  // padding: EdgeInsets.all(20),
                                  primary: Colors.green,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )),
                ],
              ))),
    );
  }
}
