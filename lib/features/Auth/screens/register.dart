import 'package:contacts/common/errorMsg.dart';
import 'package:contacts/common/fieldGap.dart';
import 'package:contacts/common/text/formTitle.dart';
import 'package:contacts/common/textfield/formTextField.dart';
import 'package:contacts/features/Auth/screens/login.dart';
import 'package:contacts/features/homePage/home.dart';
import 'package:contacts/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/button/actionBtn.dart';
import '../../../common/http_exception.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String routeName = '/register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  var passVisible = true;
  final GlobalKey<FormState> _form = GlobalKey();
  final Map<String, dynamic> _authData = {
    'fname': '',
    'lname': '',
    'phoneNo': 0,
    'email': '',
    'password': ''
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
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50.h),
              padding: EdgeInsets.all(25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTitle("Register"),
                  const FieldGap(),
                  Form(
                      key: _form,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _fnameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: const Icon(
                                  Icons.perm_identity,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.w),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                labelText: "First Name",
                                // border: Border.all(color: Colors.black12,width:1.w),
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
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _lnameFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Last Name",
                                // border: Border.all(color: Colors.black12,width:1.w),
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
                            width: 400.w,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              focusNode: _phoneFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Phone",
                                // border: Border.all(color: Colors.black12,width:1.w),
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
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Email",
                                // border: Border.all(color: Colors.black12,width:1.w),
                              ),
                              controller: emailController,
                              validator: (value) {
                                if (!value!.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!.trim();
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                          ),
                          const FieldGap(),
                          SizedBox(
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: passVisible ? true : false,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
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
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Password",
                                // border: Border.all(color: Colors.black12,width:1.w),
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
                            ),
                          ),
                          const FieldGap(),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            ActionBtn("Sing Up", submit)
                        ],
                      )),
                  const FieldGap(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 15.w),
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 16.sp),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Login.routeName);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).primaryColorDark),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
