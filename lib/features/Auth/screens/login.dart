import 'package:contacts/common/fieldGap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/errorMsg.dart';
import '../../../common/http_exception.dart';
import '../../../providers/auth.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  GlobalKey<FormState> _form = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
      await Provider.of<Auth>(context, listen: false).signin(
          _authData['email'].toString(), _authData['password'].toString());
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
              margin: EdgeInsets.only(top: 80.h),
              padding: EdgeInsets.all(25.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200.w,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/auth.png',
                        fit: BoxFit.cover, width: 150.w),
                  ),
                  const FieldGap(),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ('Login'.toUpperCase()),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.sp),
                    ),
                  ),
                  const FieldGap(),
                  Form(
                      key: _form,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  // color: iconColor,
                                  size: 20.w,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2.w),
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
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
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
                          SizedBox(
                            width: 400.w,
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.purpleAccent,
                                  size: 20.w,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).errorColor,
                                      width: 2.w),
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
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
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
                          const FieldGap(),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            Container(
                              width: 400.w,
                              //padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ElevatedButton(
                                onPressed: submit,
                                style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shadowColor: Colors.green,
                                  backgroundColor: Colors.green,
                                  minimumSize: Size.fromHeight(50.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  "Sign in".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ),
                            ),
                        ],
                      )),
                  const FieldGap(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 15.w),
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16.sp),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.routeName);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).primaryColorDark),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColorDark),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  )
                ],
              ))),
    );
  }
}
