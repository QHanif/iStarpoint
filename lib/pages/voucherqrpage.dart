import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/auth.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherQrPage extends StatelessWidget {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String voucherName = arguments['voucherName'];
    final int voucherValue = arguments['voucherValue'];
    final String voucherPicture = arguments['voucherPicture'] as String;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 237, 255),
        title: const Text('Vouchers'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            voucherPicture,
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "Scan the QR code below to enjoy your $voucherName with RM $voucherValue off!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 92, 0, 110),
              ),
            ),
          ),
          Center(
            child: QrImageView(
              data:
                  "$voucherName,$voucherValue,${user?.email ?? 'User email'} ",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrScanner()),
                );
              },
              child: const Text('qrscanner'))
        ],
      ),
    );
  }
}
