import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      home: const QrScanner(),
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

      // Get a reference to the document
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('Users').doc(email);

      // Update the document
      await docRef.update({
        'starpoint': FieldValue.increment(-int.parse(voucherValue)),
      });
    } on PlatformException {
      qrResult = 'Failed to read QR Code';
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              '$qrResult',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: scanQR, child: Text('Scan QR Code'))
          ],
        ),
      ),
    );
  }
}
