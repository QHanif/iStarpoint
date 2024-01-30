import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'QR Scanner',
      home: QrScanner(),
    );
  }
}

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String qrResult = 'Scanned Data will appear here';
  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
      });

      // Split the QR code data into a list of strings
      List<String> qrData = qrResult.split(',');

      // Extract the voucher name, voucher value, and email from the list
      String voucherName = qrData[0].trim();
      String voucherValue = qrData[1].trim();
      String email = qrData[2].trim();
      int voucherValueInt = int.parse(voucherValue.trim());

      // Get a reference to the document
      // DocumentReference docRef =
      //     FirebaseFirestore.instance.collection('Users').doc(email);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      if (email != null) {
        // Query the Users collection for the user document
        QuerySnapshot userQuery = await firestore
            .collection('Users')
            .where('Email', isEqualTo: email)
            .get();

        // Get the user's document
        DocumentSnapshot userDoc = userQuery.docs.first;

        // Increase the user's starpoints by 30
        int newStarpoints = userDoc['Starpoints'] - voucherValueInt;

        // Update the user's document
        await firestore
            .collection('Users')
            .doc(userDoc.id)
            .update({'Starpoints': newStarpoints});

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success!'),
              content: Text(
                  '$voucherName with RM ${(voucherValueInt / 100).toInt()} off has been redeemed!'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      // Update the document
      // await docRef.update({
      //   'starpoint': FieldValue.increment(-int.parse(voucherValue)),
      // });
    } on PlatformException {
      qrResult = 'Failed to read QR Code';
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              qrResult,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: scanQR, child: const Text('Scan QR Code'))
          ],
        ),
      ),
    );
  }
}
