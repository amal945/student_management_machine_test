import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/view/admin/admin_dash_screen.dart';
import 'package:student_management/view/staff/staff_dashboard.dart';
import 'package:student_management/view/student/student_dashboad.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  // Function to handle sign-in
  Future<void> signIN() async {
    String email = userNameController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields")),
      );
      return;
    }

    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      // Function to check each collection for the user by email
      Future<bool> checkCollection(String collectionName, Widget screen) async {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .where('email', isEqualTo: email) // Check if the email matches
            .get();

        if (snapshot.docs.isNotEmpty) {
          // If user exists in the collection, navigate to the appropriate screen
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => screen));
          return true;
        }
        return false;
      }

      // Check Admin collection
      if (await checkCollection('Admin', AdminDashScreen())) {
        return;
      }

      // Check Staff collection
      if (await checkCollection('Staff', StaffDashboard())) {
        return;
      }

      // Check Student collection
      if (await checkCollection('Student', StudentDashboad())) {
        return;
      }

      // If user is not found in any collection
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User does not exist in any collection")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 90,
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              // Username TextField
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: userNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Username",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Password TextField
              TextField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible; // Toggle visibility
                      });
                    },
                    icon: isVisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Password",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Submit Button
              GestureDetector(
                onTap: signIN, // Call the signIN method when tapped
                child: Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.yellow,
                  ),
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
