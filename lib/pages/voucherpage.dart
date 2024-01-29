import 'package:flutter/material.dart';
import 'package:iStarpoint/util/voucherdetails.dart';

class VoucherPage extends StatelessWidget {
  Widget _voucher(BuildContext context, Map<String, dynamic> voucher) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 0, 7, 112),
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 2, // 20%
                child: Image.asset(voucher['voucherPicture'],
                    width: 50, height: 50),
              ), // Add image at the start of the row
              SizedBox(width: 20),
              Expanded(
                flex: 5, // 50%
                child: Text(
                    voucher['voucherName'] +
                        '\nRM' +
                        voucher['voucherValue'].toString() +
                        ' off',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 160, 0, 192))),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 3, // 30%
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/voucherqrpage',
                      arguments: {
                        'voucherName': voucher['voucherName'],
                        'voucherValue': voucher['voucherValue'],
                        'voucherPicture': voucher['voucherPicture'],
                      },
                    );
                  },
                  child: const Text('Claim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 237, 255),
        title: const Text('Vouchers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: voucherDetails
              .map((voucher) =>
                  _voucher(context, voucher)) // Pass context to _voucher
              .toList(), //  Use the eventDetails list to create the VOUCHER widgets
        ),
      ),
    );
  }
}
