import 'package:contacts/features/contacts/contactDetail.dart';
import 'package:contacts/features/contacts/createContacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'common/splashScreen/splash_screen.dart';
import 'features/Auth/screens/login.dart';
import 'features/Auth/screens/profile.dart';
import 'features/Auth/screens/register.dart';
import 'features/homePage/home.dart';
import 'providers/auth.dart';
import 'providers/contact.dart';

void main() {
  runApp(MyApp());
}

//rzp_test_ovopv6bm1rGf6q //keyid
//MzVihCR05CyhFXF7ppliRYnw //keysecret
class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  Color greenLight = const Color(0xff63d47a);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ContactProvider>(
              update: (ctx, auth, previousState) => ContactProvider(
                  auth.token.toString(),
                  previousState == null ? [] : previousState.contacts),
              create: (_) => ContactProvider('', []))
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return Consumer<Auth>(
                  builder: (ctx, auth, _) => MaterialApp(
                        title: 'Contacts',
                        theme: ThemeData(
                            primaryColor: Colors.purple,
                            primaryColorDark: Colors.purple[800],
                            primaryColorLight: greenLight,
                            colorScheme: ThemeData.light().colorScheme.copyWith(
                                secondary: Colors.purple.shade200,
                                primary: Colors.purple.shade600,
                                error: Colors.red)),
                        home: auth.isAuth
                            ? const Home()
                            : FutureBuilder(
                                future: auth.tryAutoLogin(),
                                builder: (ctx, authResultSnapshot) {
                                  print({'main', authResultSnapshot.data});
                                  return authResultSnapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? const SplashScreen()

                                      ///: authResultSnapshot.data == false
                                      : const Login();
                                }),
                        routes: {
                          '/home': (ctx) => const Home(),
                          Login.routeName: (ctx) => const Login(),
                          Register.routeName: (ctx) => const Register(),
                          Profile.routeName: (ctx) => const Profile(),
                          CreateContact.routeName: (ctx) =>
                              const CreateContact(),
                          ContactDetails.routeName: (ctx) =>
                              const ContactDetails(),
                        },
                      ));
            }));
  }
}
