// qoys

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


import '../auth.dart';
import '../util/validate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Validator validator = Validator();
  String? errorMessage = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _kulliyyahController = TextEditingController();


  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      // Registration successful, show a dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('Click OK to go to the Homepage screen.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close the register screen
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                'The account already exists for that email. Login instead.';
            break;
          default:
            errorMessage =
                'An unknown error occurred with error code: ${e.code}.';
        }
      });
    }
  }
  final User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerUsername,
                  validator: validator.validateDisplayName,
                  decoration: InputDecoration(
                    fillColor: Colors.white, // Set the fill color to white
                    filled: true, // Enable fill color
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Make the border disappear
                      borderRadius: BorderRadius.circular(
                          30.0), // Keep the border rounded
                    ),

                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _controllerEmail,
                  validator: validator.validateEmail,
                  decoration: InputDecoration(
                    fillColor: Colors.white, // Set the fill color to white
                    filled: true, // Enable fill color
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Make the border disappear
                      borderRadius: BorderRadius.circular(
                          30.0), // Keep the border rounded
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: _isHiddenPassword,
                  validator: validator.validatePassword,
                  decoration: InputDecoration(
                    fillColor: Colors.white, // Set the fill color to white
                    filled: true, // Enable fill color
                    labelText: 'Password',
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Make the border disappear
                      borderRadius: BorderRadius.circular(
                          30.0), // Keep the border rounded
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _controllerConfirmPassword,
                  obscureText: _isHiddenPassword,
                  validator: (value) {
                    return validator.validateRepeatPassword(
                        value, _controllerPassword.text);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white, // Set the fill color to white
                    filled: true, // Enable fill color
                    labelText: 'Confirm Password',
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Make the border disappear
                      borderRadius: BorderRadius.circular(
                          30.0), // Keep the border rounded
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                //occupation
                TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _kulliyyahController,
                  decoration: InputDecoration(
                    fillColor: Colors.white, // Set the fill color to white
                    filled: true, // Enable fill color
                    labelText: 'Kulliyah',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Make the border disappear
                      borderRadius: BorderRadius.circular(
                          30.0), // Keep the border rounded
                    ),
                  ),

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                ),
                Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',
                    style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await createUserWithEmailAndPassword();

                      try {
                        Map<String, dynamic> userData = {
                          'Email': _controllerEmail.text,
                          'Kulliyyah': _kulliyyahController.text,
                          'Starpoints': 0,
                        };
                        await DatabaseMethods().register(userData);

                        // Showing Snack Bar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account Created Successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        // Wait for 3 seconds and then navigate back
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      } catch (e) {
                        print('Error creating account: $e');
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DatabaseMethods {
  Future register(Map<String, dynamic> userData) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc()
        .set(userData);
  }
}
