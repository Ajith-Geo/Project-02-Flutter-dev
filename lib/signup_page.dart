import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  SignupPage({Key? key});

  Future<void> _signUpAndSendOTP(BuildContext context) async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        // If passwords do not match, show an error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Create user account without signing in
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send OTP to the provided phone number
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback will be invoked if the auto-detection is successful.
          // You can sign in the user directly with the credential (credential)
          // or call setState and enter the code manually.
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle the verification failure, such as incorrect phone number format.
          print('Phone number verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Handle the code being sent to the user's phone here.
          // You can navigate to another page to input the received code.
          // Save the verificationId and navigate to the code verification page.
          // For example:
          Navigator.pushReplacementNamed(
            context,
            '/verify_otp',
            arguments: {
              'verificationId': verificationId,
              'phoneNumber': phoneController.text,
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback will be invoked after a timeout and could be used to resend the code.
        },
      );

      // If required, additional user data can be stored in Firestore here
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': nameController.text,
        'age': ageController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        // Add more fields if needed
      });

      Navigator.pushReplacementNamed(context, '/ground');
    } catch (e) {
      // Handle exceptions
      print('Error signing up or sending OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _signUpAndSendOTP(context);
              },
              child: const Text('Sign Up & Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
