import 'package:contacts/features/Auth/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String routeName = '/register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  FocusNode _fnameFocusNode = FocusNode();
  FocusNode _lnameFocusNode = FocusNode();
  var _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _lnameFocusNode.dispose();
    _fnameFocusNode.dispose();
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
                            // _authData['email'] = value!;
                            print(value);
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_lnameFocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                            // _authData['email'] = value!;
                            print(value);
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
                            // _authData['email'] = value!;
                            print(value);
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
                            // _authData['email'] = value!;
                            print(value);
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
                          // padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(
                            child: Text(
                              "Sign up".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {},
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
                                borderRadius: new BorderRadius.circular(30.0),
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
                            "Already have an account?",
                            style: TextStyle(fontSize: 16),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Login.routeName);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColorDark),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
