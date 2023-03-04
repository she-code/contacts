import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                      ('Login'.toUpperCase()),
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
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
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
                          SizedBox(
                            height: 20,
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            Container(
                              width: 400,
                              //padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(
                                child: Text(
                                  "Sign in".toUpperCase(),
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.routeName);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark),
                  )
                ],
              ))),
    );
  }
}
