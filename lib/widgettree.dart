//saufi

import 'package:iStarpoint/auth.dart';
import 'package:iStarpoint/pages/homepage.dart';
// import 'package:iStarpoint/pages/loginregister.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/pages/loginscreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
