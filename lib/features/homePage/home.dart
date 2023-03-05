import 'package:contacts/features/contacts/createContacts.dart';
import 'package:contacts/features/homePage/widgets/contactCards.dart';
import 'package:contacts/providers/auth.dart';
import 'package:contacts/providers/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  var _isLoading = false;
  var _isinit = true;
  Color backG = const Color(0xFFE6E7E9);

  Future<void> _refreshContacts(BuildContext context) async {
    await Provider.of<ContactProvider>(context, listen: false).getContacts();
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ContactProvider>(context)
          .getContacts()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isinit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final contacts =
        Provider.of<ContactProvider>(context, listen: false).contacts;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            actions: [
              Container(
                  decoration: BoxDecoration(
                      color: backG, borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(13),
                  //padding: EdgeInsets.all(8),
                  // width: 12,
                  // height: 12,
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: backG, borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.all(15),
                  //padding: EdgeInsets.all(8),
                  width: 30,
                  // height: 12,
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 20,
                  )),
            ],
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text(
              "Dashboard",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
            centerTitle: true,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshContacts(context),
          child: SingleChildScrollView(
              child: Container(
                  color: backG,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.w),
                  margin: EdgeInsets.only(top: 50.h),
                  child: Column(
                    children: [
                      const Text('hhfld'),
                      TextButton(
                          onPressed: () async {
                            await Provider.of<Auth>(context, listen: false)
                                .logout();
                          },
                          child: const Text('logout')),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          child: SizedBox(
                            // decoration: BoxDecoration(boxShadow: ),
                            width: 400.w,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                focusColor: Colors.purple,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  // color: iconColor,
                                  size: 20,
                                ),

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
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: ((context, index) => ContactCards(
                                  contacts[index].id,
                                  contacts[index].fname,
                                  contacts[index].lname,
                                  contacts[index].email,
                                  contacts[index].phoneNo)),
                              itemCount: contacts.length,
                            ),
                      //),
                      //   )
                    ],
                  ))),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (() =>
                Navigator.of(context).pushNamed(CreateContact.routeName)),
            child: const Icon(Icons.add)));
  }
}
