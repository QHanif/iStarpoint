import 'package:flutter/material.dart';
import 'package:iStarpoint/qrscanner/qrscanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


void main () {
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
  String qrResult='Scanned Data will appear here';

  Future<void> scanQR() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrResult = qrCode.toString();
      });

    }on PlatformException{
      qrResult = 'Failed to read QR Code';}
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
              Text('$qrResult',style:TextStyle(color:Colors.black),),
              SizedBox(height: 30),
              ElevatedButton(onPressed: scanQR, child: Text('Scan QR Code'))
          ],
        ),
      ),
    );
  }
}