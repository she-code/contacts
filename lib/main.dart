import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/splashScreen/splash_screen.dart';
import 'features/Auth/screens/login.dart';
import 'features/Auth/screens/register.dart';
import 'features/homePage/home.dart';
import 'providers/auth.dart';

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
          // ChangeNotifierProxyProvider<Auth, ContactProvider>(
          //     update: (ctx, auth, previousState) => ContactProvider(
          //         auth.token.toString(),
          //         previousState == null ? [] : previousState.presses),
          //     // PressProvider(auth.token!, previousState!.presses),
          //     create: (_) => PressProvider('', []))
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Udhyog',
                  theme: ThemeData(
                      primaryColor: Colors.green,
                      primaryColorDark: Colors.green[800],
                      primaryColorLight: greenLight,
                      colorScheme: ThemeData.light().colorScheme.copyWith(
                          secondary: Colors.orange,
                          primary: Colors.green,
                          error: Colors.red)),
                  home: auth.isAuth
                      ? Home()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()

                                  ///: authResultSnapshot.data == false
                                  : const Login()
                          // : MainPage(),
                          ),

                  // initialRoute: '/login',
                  routes: {
                    '/home': (ctx) => Home(),
                    Login.routeName: (ctx) => Login(),
                    Register.routeName: (ctx) => Register(),

                    //  AddPress.routeName:(ctx) => AddPress(),
                  },
                )));
  }
}