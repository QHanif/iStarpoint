import 'dart:ui';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset('assets/images/logo2.png'),
        ),
        backgroundColor: Colors.purple[300],
        title: const Text('I-STARPOINTS'),
        actions: [
          Tooltip(
            // Add a tooltip
            message: 'Logout',
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: _signOut,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome  ${user?.displayName ?? ''}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: Image.network(
                            'https://www.metrocontinuingeducation.ca/wp-content/uploads/2019/01/in-class-students-high-school.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.person,
                                  size: 60.0,
                                ),
                                title: const Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: Image.network(
                            'https://events.utk.edu/wp-content/uploads/sites/65/2019/01/firstgen.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.event,
                                  size: 60.0,
                                ),
                                title: const Text(
                                  'Event',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EventPage()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: 0.4,
                          child: Image.network(
                            'https://www.bhg.com.au/media/29898/gifts-present.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.card_giftcard,
                                  size: 60.0,
                                ),
                                title: const Text(
                                  'Voucher',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VoucherPage()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
