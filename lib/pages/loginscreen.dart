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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[100],
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: 250.0,
                height: 250.0,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerEmail,
                validator: validator.validateEmail,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerPassword,
                obscureText: _isHiddenPassword,
                validator: validator.validatePassword,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true, // Enable fill color
                  border: InputBorder.none,
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    // onPressed: _togglePasswordView,
                  ),
                ),
              ),
              Text(errorMessage == '' ? '' : 'Hmm ? $errorMessage',
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signInWithEmailAndPassword();
                  } // Handle login logic here
                },
              ),
              TextButton(
                child: const Text('Forgot password?'),
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotpassword');
                },
              ),
              SizedBox(height: 10),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Go to Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
