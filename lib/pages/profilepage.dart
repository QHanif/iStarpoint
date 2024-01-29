import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/components/text_box.dart';

// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   final User? user = Auth().currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple[300],
//         title: Text('Profile Page'),
//       ),
//       body:  Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//               border: Border.all(color: Colors.blueAccent),
//               borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Text(
//                 'Username:  ${user?.displayName ?? ''}',
//                     style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold, // Make the text bold
//                   ),
//                 ),
//               ),
//             Container(
//               padding: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//               border: Border.all(color: Colors.blueAccent),
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//               child: Text(
//                 'Email:  ${user?.email?? ''}',
//                   style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold, // Make the text bold
//                 ),
//               ),
//             ),
//               Container(  
//                 padding: EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                 border: Border.all(color: Colors.blueAccent),
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//                 child: Text(
//                   'Kulliyyah:  ${user?.displayName ?? ''}',
//                     style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold, // Make the text bold
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void>editField(String field)async{
    String newValue = '';
    await showDialog(
      context: context,
      builder:(context)=> AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter new $field',
          hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) => newValue = value,
        ),
        actions:[
          TextButton(
            child:Text('Cancel'),
            onPressed: ()=> Navigator.of(context).pop(),
          ),

          TextButton(
            child:Text('Save'),
            onPressed: ()=> Navigator.of(context).pop(newValue),
          )
        ]
      ),
    );
    if (newValue.trim().length>0){
      await userCollection.doc(currentUser?.email).update({
        field: newValue,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 180, 203),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 176, 208),
        title: Text('Profile Page'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser?.email).snapshots(),
        builder: (context, snapshot) {
         if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
        children: [
          const SizedBox(height: 50),

          const Icon(
            Icons.person,
            size:72,
            ),

            const SizedBox(height: 20),

          Text(
            currentUser!.email! ,
            textAlign: TextAlign.center,
          ), 

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'My details',
              
              textAlign: TextAlign.center,
              style: const TextStyle(
              ),
            ),
          ),
          MyTextBox(
            text:userData['username'].toString(),
            sectionName: 'Username',
            onPressed:()=> editField('username'),
          ),

          MyTextBox(
            text:userData['kulliyyah'].toString(),
            sectionName: 'Kulliyyah',
            onPressed:()=> editField('kulliyyah'),
          ),
        ],
      );
         } else if (snapshot.hasError){
          return Center(
            child: Text('Something went wrong'),
          );
         }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }
}