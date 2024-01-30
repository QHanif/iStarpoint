import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/util/voucherdetails.dart';
import 'package:iStarpoint/auth.dart';

class VoucherPage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where('Email', isEqualTo: currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final userData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            return ListView(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.star), // Add this line
                      SizedBox(
                          width:
                              8.0), // Add some spacing between the icon and the text
                      Text(
                        'Starpoints: ${userData['Starpoints'].toString()}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: voucherDetails
                        .map((voucher) => _voucher(
                            context, voucher)) // Pass context to _voucher
                        .toList(), //  Use the eventDetails list to create the VOUCHER widgets
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
      ),
    );
  }
}
