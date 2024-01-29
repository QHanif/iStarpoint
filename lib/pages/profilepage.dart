import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iStarpoint/auth.dart';
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

  Future<void>editField(String Field)async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 180, 203),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 176, 208),
        title: Text('Profile Page'),
      ),
// <<<<<<< azhad
//       body: ListView(
//         children: [
//           const SizedBox(height: 50),

//           const Icon(
//             Icons.person,
//             size:72,
//             ),

//             const SizedBox(height: 20),

//           Text(
//             currentUser!.email! ,
//             textAlign: TextAlign.center,
//           ), 

//           const SizedBox(height: 20),

//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'My details',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//               ),
//             ),
//           ),
//           MyTextBox(
//             text:'username',
//             sectionName: 'Username',
//             onPressed:()=> editField('username'),
//           ),

//           MyTextBox(
//             text:'kulliyyah',
//             sectionName: 'Kulliyyah',
//             onPressed:()=> editField('kulliyyah'),
//           ),
//         ],
// =======
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Username:  ${user?.displayName ?? ''}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Email:  ${user?.email ?? ''}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Kulliyyah:  ${user?.displayName ?? ''}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ],
        ),
// >>>>>>> main
      ),
    );
  }
}
