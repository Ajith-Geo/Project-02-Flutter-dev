import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        actions: [
          // Adding a logout button to the app bar
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Login successful!'),
      ),
    );
  }
}
