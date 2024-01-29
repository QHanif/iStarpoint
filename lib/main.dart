import 'dart:io';

import 'package:iStarpoint/pages/forgotpassword.dart';
import 'package:iStarpoint/pages/voucherqrpage.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:iStarpoint/widgettree.dart';
//qoys

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/pages/loginscreen.dart';
import 'package:iStarpoint/pages/registerscreen.dart';
import 'package:iStarpoint/pages/eventdetailpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          appId: '1:195063921079:android:a034ddc9d23f4275e0d032',
          messagingSenderId: '195063921079',
          projectId: 'fir-cs2',
          apiKey: 'AIzaSyDAWq2sokNaM10ZUEAT91yNDQILA3pUa5Y',
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/eventdetail': (context) => EventDetailPage(
              eventIndex:
                  ModalRoute.of(context)!.settings.arguments as int? ?? 0,
            ),
        '/voucherqrpage': (context) => VoucherQrPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
        '/qrscanner': (context) => const QrScanner(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}
