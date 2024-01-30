import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/util/text_box.dart';
import 'package:iStarpoint/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  String? username;

  @override
  void initState() {
    super.initState();
    username = currentUser?.displayName;
  }

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) => newValue = value,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () => Navigator.of(context).pop(newValue),
            )
          ]),
    );
    if (newValue.trim().isNotEmpty) {
      if (field == 'Username') {
        User? user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName(newValue);
        await user?.reload();
        setState(() {
          username = newValue;
        });
      } else {
        // Query the Users collection for the user document
        QuerySnapshot userQuery = await userCollection
            .where('Email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .get();

        if (userQuery.docs.isNotEmpty) {
          // Update the field in Firestore
          await userCollection.doc(userQuery.docs.first.id).update({
            field: newValue,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 180, 203),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 176, 208),
        title: const Text('Profile Page'),
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
                const SizedBox(height: 50),
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 20),
                Text(
                  currentUser!.email!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                MyTextBox(
                  text: Auth().currentUser?.displayName ?? 'No username',
                  sectionName: 'Username',
                  onPressed: () => editField('Username'),
                ),
                MyTextBox(
                  text: userData['Kulliyyah'].toString(),
                  sectionName: 'Kulliyyah',
                  onPressed: () => editField('Kulliyyah'),
                ),
                SizedBox(height: 20),
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
