import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/splashScreen/splash_screen.dart';
import 'features/Auth/screens/login.dart';
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
  Color greenLight = Color(0xff63d47a);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ChangeNotifierProvider.value(
          //   value: OrderProvider(),
          // ),
          // ChangeNotifierProvider(
          //   create: (ctx) => PressProvider('', []),
          // ),
          ChangeNotifierProxyProvider<Auth, ContactProvider>(
              update: (ctx, auth, previousState) => ContactProvider(
                  auth.token.toString(),
                  previousState == null ? [] : previousState.contacts),
              // PressProvider(auth.token!, previousState!.presses),
              create: (_) => ContactProvider('', []))
        ],
        child: Consumer<Auth>(builder: (ctx, auth, _) {
          print({'from consumer', auth.isAuth});
          return MaterialApp(
            title: 'Contacts',
            theme: ThemeData(
                primaryColor: Colors.green,
                primaryColorDark: Colors.green[800],
                primaryColorLight: greenLight,
                colorScheme: ThemeData.light().colorScheme.copyWith(
                    secondary: Colors.orange,
                    primary: Colors.green,
                    error: Colors.red)),

            home: Home(),
            // auth.token != null
            //     ? Home()
            //     : FutureBuilder(
            //         future: auth.tryAutoLogin(),
            //         builder: (ctx, authResultSnapshot) {
            //           print({'main', authResultSnapshot.data});
            //           return authResultSnapshot.connectionState ==
            //                   ConnectionState.waiting
            //               ? SplashScreen()

            //               ///: authResultSnapshot.data == false
            //               : const Login();
            //         }
            //         // : MainPage(),
            //         ),

            // initialRoute: '/login',
            routes: {
              '/home': (ctx) => Home(),
              Login.routeName: (ctx) => Login(),
              Register.routeName: (ctx) => Register(),

              //  AddPress.routeName:(ctx) => AddPress(),
            },
          );
        }));
  }
}
