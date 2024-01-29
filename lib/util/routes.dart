import 'package:flutter/material.dart';
import 'package:iStarpoint/pages/loginscreen.dart';
import 'package:iStarpoint/pages/registerscreen.dart';
import 'package:iStarpoint/pages/eventpage.dart';
import 'package:iStarpoint/pages/eventdetailpage.dart';
import 'package:iStarpoint/pages/profilepage.dart';
import 'package:iStarpoint/pages/voucherpage.dart';
import 'package:iStarpoint/pages/voucherqrpage.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  '/eventpage': (context) => const EventPage(),
  '/eventdetail': (context) => EventDetailPage(
        eventIndex: ModalRoute.of(context)!.settings.arguments as int? ?? 0,
      ),
  '/voucherpage': (context) => VoucherPage(),
  '/voucherqrpage': (context) => const VoucherQrPage(),
  '/qrscanner': (context) => const QrScanner(),
  '/profilepage': (context) => const ProfilePage(),
};
