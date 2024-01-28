import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import '../util/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validator validator = Validator();
  String? errorMessage = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[100], // Set the background color to light blue
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                fillColor: Colors.white, // Set the fill color to white
                filled: true, // Enable fill color
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controllerPassword,
              obscureText: _isHiddenPassword,
              decoration: InputDecoration(
                fillColor: Colors.white, // Set the fill color to white
                filled: true, // Enable fill color
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordView,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                // Handle login logic here
              },
            ),
            TextButton(
              child: Text('Forgot password?'),
              onPressed: () {
                // Handle forgot password logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
