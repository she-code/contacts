import 'package:contacts/features/homePage/widgets/contactCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 50),
                //  height: 300,
                // ScreenUtil().screenHeight,
                child: Column(
                  children: [
                    Text('hhfld'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        child: Container(
                          // decoration: BoxDecoration(boxShadow: ),
                          width: 400,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: Colors.grey,
                              focusColor: Colors.purple,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                // color: iconColor,
                                size: 20,
                              ),
                              // errorBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //       color: Theme.of(context).errorColor,
                              //       width: 2),
                              //   borderRadius: BorderRadius.circular(20.0),
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.black, width: 1),
                              //   borderRadius: BorderRadius.circular(20.0),
                              // ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //       color: Colors.lightGreenAccent.shade400,
                              //       width: 1.5),
                              //   borderRadius: BorderRadius.circular(20.0),
                              // ),
                              labelText: "Search",
                              // border: Border.all(color: Colors.black12,width: 2),
                            ),
                            controller: searchController,
                            validator: (value) {
                              if (value!.length < 2) {
                                return 'Search field must atleast contain two characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // _authData['email'] = value!;
                              print(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => ContactCards()),
                      itemCount: 6,
                    ),
                    //),
                    //   )
                  ],
                ))),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {}),
        ));
  }
}
