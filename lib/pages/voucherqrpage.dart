import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/auth.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherQrPage extends StatelessWidget {
  final User? user = Auth().currentUser;
  final currentUser = FirebaseAuth.instance.currentUser;
  int? previousStarpoints;
  VoucherQrPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final String voucherName = arguments['voucherName'];
    final int voucherValue = arguments['voucherValue'];
    final String voucherPicture = arguments['voucherPicture'] as String;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 237, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 237, 255),
          title: const Text('Vouchers'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .where('Email', isEqualTo: currentUser?.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final userData =
                  snapshot.data!.docs.first.data() as Map<String, dynamic>;
              int currentStarpoints = userData.containsKey('Starpoints')
                  ? userData['Starpoints']
                  : 0;
              if (previousStarpoints == null) {
                previousStarpoints = currentStarpoints;
              } else if (currentStarpoints < previousStarpoints!) {
                int deductedPoints = previousStarpoints! - currentStarpoints;
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: Text(
                            'You have successfully redeemed your voucher. $deductedPoints Starpoints have been deducted from your account.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              }

              previousStarpoints = currentStarpoints;

              return ListView(
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
                          "$voucherName,${voucherValue * 100},${user?.email ?? 'User email'} ",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
