import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/view/student/student_dashboad.dart';

import '../admin/admin_dash_screen.dart';
import '../login screen/login_screen.dart';
import '../staff/staff_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    Future.delayed(const Duration(seconds: 2), () async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // Navigate to LoginScreen if no user is logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        try {
          // Fetch user data from Firestore
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('Users') // Replace with the appropriate collection
              .doc(user.uid)
              .get();

          if (userDoc.exists) {
            String role = userDoc.get('role');

            // Navigate based on role
            if (role == 'Admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminDashScreen()),
              );
            } else if (role == 'Staff') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StaffDashboard()),
              );
            } else if (role == 'Student') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StudentDashboad()),
              );
            } else {
              // Default behavior for unrecognized roles
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          } else {
            // If user document does not exist in Firestore
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        } catch (e) {
          // Handle any errors during navigation or fetching user data
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                size: 100,
                color: Colors.white,
              ),
              Text(
                "Student Portal",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
