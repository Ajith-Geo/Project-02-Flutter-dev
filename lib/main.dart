import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'ground_truth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Required for Firebase initialization
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if a user is already logged in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(
    MaterialApp(
      initialRoute: user != null ? '/home' : '/', // Redirect accordingly
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/success': (context) => const SuccessPage(),
        '/SignupPage': (context) => SignupPage(),
        '/home': (context) => DiabetesPredictionPage(),
        '/ground': (context) => GroundTruthPage(),
      },
    ),
  );
}
//https://www.youtube.com/watch?v=ZgOGWCJJ4jU
//https://github.com/CloudHustlers/LEVEL_1_SEP/blob/main/10_Analytics%20as%20a%20Service%20for%20Data%20Sharing%20Partners%20.md
// runApp(
//   MaterialApp(
//     initialRoute: '/', // Set the initial route to '/home'
//     routes: {
//       '/': (context) => const HomePage(), // Add a route to the HomePage
//       '/login': (context) => const LoginPage(),
//       '/success': (context) => const SuccessPage(),
//       '/SignupPage': (context) => SignupPage(),
//     },
//   ),
// );
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigate to LoginPage
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/SignupPage'); // Navigate to LoginPage
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
