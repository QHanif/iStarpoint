import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/auth.dart';
import 'package:iStarpoint/pages/voucherpage.dart';
import 'package:iStarpoint/pages/eventpage.dart';

import 'package:iStarpoint/pages/profilepage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> _signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text('Email: ${user?.email ?? 'User email'}');
  }

  Widget _userUsername() {
    return Text('Username: ${user?.displayName ?? 'User username'}');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: _signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('I-STARPOINTS'),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                width: 150.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  icon: const Icon(Icons.account_circle),
                  label: const Text('Profile'),
                ),
              ),
            ),
          ),
          _userUsername(),
          _userUid(),
          _signOutButton(),
          SizedBox(height: 150),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventPage()),
                      );
                    },
                    child: const Text('Events'),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoucherPage()),
                      );
                    },
                    child: const Text('Claim'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
