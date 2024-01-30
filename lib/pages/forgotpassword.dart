import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'A password reset link has been sent to ${_emailController.text.trim()}'),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Error: ${e.toString()}'),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text('Forgot Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add a back button
          onPressed: () =>
              Navigator.pop(context), // Navigate to the previous page
        ),
      ),
      body: Container(
        color: Colors.purple[100], // This will make the background blue
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Please enter your email, we will send you a link to reset your password.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Enter your email',
                    border:
                        OutlineInputBorder(), // Add a border to the TextField
                    contentPadding: EdgeInsets.all(10), // Add some padding
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Add some spacing
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15), // Add some padding
                      // Increase text size
                    ),
                    child: const Text('Reset Password'),
                    onPressed: () {
                      passwordResetEmail();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
