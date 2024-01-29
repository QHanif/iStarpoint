import 'package:flutter/material.dart';
import 'package:iStarpoint/util/voucherdetails.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  Widget _voucher(BuildContext context, Map<String, dynamic> voucher) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 0, 7, 112),
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 2, // 20%
                child: Image.asset(voucher['voucherPicture'],
                    width: 50, height: 50),
              ), // Add image at the start of the row
              const SizedBox(width: 20),
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
              const SizedBox(width: 20),
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

                //  ElevatedButton(
                //   onPressed: () {},
                //   child: Text('Claim'),
                // ),
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
      backgroundColor: const Color.fromARGB(255, 255, 237, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 255),
        title: const Text('Vouchers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              // _voucher("Nasi Lemak", 2, "assets/images/nasilemak.png"),
              // _voucher("Satay", 3, "assets/images/satay.png"),
              // _voucher("Rendang", 3, "assets/images/rendang.png"),
              // _voucher("Mee Goreng", 2, "assets/images/meegoreng.png"),
              // _voucher("Roti Canai", 2, "assets/images/roticanai.png"),
              // _voucher("Briyani", 5, "assets/images/briyani.png"),
              // _voucher("Coconut Shake", 2, "assets/images/coconut.png"),
              // _voucher("Laksa", 3, "assets/images/laksa.png"),
              // _voucher("Ayam Percik", 3, "assets/images/ayampercik.png"),
              // _voucher("Keropok Lekor", 2, "assets/images/keropoklekor.png"),
              // _voucher("Cendol", 1, "assets/images/cendol.png"),
              voucherDetails
                  .map((voucher) =>
                      _voucher(context, voucher)) // Pass context to _voucher
                  .toList(), //  Use the eventDetails list to create the VOUCHER widgets
        ),
      ),
    );
  }
}
