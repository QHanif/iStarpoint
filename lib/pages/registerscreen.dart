// qoys

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import '../auth.dart';
import '../util/validate.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const List<String> gender = <String>['Male', 'Female'];

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Validator validator = Validator();
  String? errorMessage = '';
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _kulliyyahController = TextEditingController();
  String dropdownValue = gender.first;
  DateTime? _selectedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        // Check if a date is selected
        setState(() {
          _selectedDate = value;
          _dobController.text = DateFormat('dd-MM-yyyy').format(value);
        });
      }
    });
  }

  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'invalid-credential':
            errorMessage = 'Invalid email/password entered. Please try again.';
            break;
          default:
            errorMessage =
                'An unknown error occurred with error code: ${e.code}.';
        }
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        username: _controllerUsername.text,
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

  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Container(
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
                    borderRadius:
                        BorderRadius.circular(30.0), // Keep the border rounded
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
                    borderRadius:
                        BorderRadius.circular(30.0), // Keep the border rounded
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
                    borderRadius:
                        BorderRadius.circular(30.0), // Keep the border rounded
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
                    borderRadius:
                        BorderRadius.circular(30.0), // Keep the border rounded
                  ),
                ),
              ),

              //age
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                  ],
                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
              ),

              //gender
              Container(
                margin: const EdgeInsets.all(10),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  value: dropdownValue,
                  items: gender.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please choose your gender';
                    }
                    return null;
                  },
                ),
              ),

              //dob
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 230,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 18),
                            controller: _dobController,
                            decoration: const InputDecoration(
                                labelText: 'Date of Birth'),

                            //validatorr
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date of birth';
                              }
                              return null;
                            },
                          ),
                        ),
                        MaterialButton(
                          onPressed: _showDatePicker,
                          color: Colors.blue,
                          child: const Text(
                            'Select date',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ])),

              //occupation
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _kulliyyahController,
                  decoration: const InputDecoration(labelText: 'Kulliyyah'),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z '-]")),
                    LengthLimitingTextInputFormatter(30),
                  ],

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                ),
              ),
              Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',
                  style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await createUserWithEmailAndPassword();
                    await signInWithEmailAndPassword();

                    try {
                      Map<String, dynamic> userData = {
                        'ID': user!.uid,
                        'Name': _controllerUsername.text,
                        'Age': _ageController.text,
                        'Gender': dropdownValue,
                        'DOB': _dobController.text,
                        'Kulliyyah': _kulliyyahController.text,
                      };
                      await DatabaseMethods().register(userData, user!.uid);

                      // Showing Snack Bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account Created Successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Wait for 3 seconds and then navigate back
                      Future.delayed(Duration(seconds: 2), () {
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
    );
  }
}

class DatabaseMethods {
  Future register(Map<String, dynamic> userData, String id) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userData);
  }

  Future<Stream<QuerySnapshot>> getPatientData() async {
    return await FirebaseFirestore.instance.collection('Users').snapshots();
  }
}
