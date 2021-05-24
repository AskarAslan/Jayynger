import 'package:flutter/material.dart';
import 'package:flutter_app/screens/landing.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'domain/user.dart';
import 'package:flutter/cupertino.dart';

import 'models/cart_model.dart';

void main() => runApp(MultiProvider(
  providers: [ChangeNotifierProvider.value(value: CartItems())],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),

  ),
),);

  class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
      return StreamProvider<User>.value(
        value: AuthService().currentUser,
        child: MaterialApp(
            title: '',
            theme: ThemeData(
                primaryColor: Color.fromRGBO(50, 65, 85, 1),
                textTheme: TextTheme(title: TextStyle(color: Colors.white))),
            home: LandingPage()),
      );
    }
}


