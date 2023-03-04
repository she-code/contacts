import 'package:contacts/common/errorMsg.dart';
import 'package:contacts/common/fieldGap.dart';
import 'package:contacts/common/textfield/formTextField.dart';
import 'package:contacts/features/Auth/screens/login.dart';
import 'package:contacts/features/homePage/home.dart';
import 'package:contacts/providers/auth.dart';
import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../common/http_exception.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({super.key});
  static String routeName = '/createContact';
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
      await Provider.of<ContactProvider>(context, listen: false).createContact(
          _authData['fname'].toString(),
          _authData['lname'].toString(),
          _authData['email'].toString(),
          int.parse(_authData['phoneNo']));
      Navigator.of(context).pushReplacementNamed(Home.routeName);
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
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )),
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ('Create Contact'.toUpperCase()),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  const FieldGap(),
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
                                prefixIcon: const Icon(
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
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
                          const FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _lnameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: const Icon(
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
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
                          const FieldGap(),
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
                                prefixIcon: const Icon(
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
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
                          const FieldGap(),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: const Icon(
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
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
                          const FieldGap(),

                          if (_isLoading)
                            const CircularProgressIndicator()
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
