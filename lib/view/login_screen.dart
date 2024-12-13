import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/view/admin/admin_dash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isVisible = false;

  // Function to handle sign-in
  Future<void> signIN() async {
    String email = _userNameController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show a snack bar if the username or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields")),
      );
      return;
    }

    try {
      // Sign in with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If login is successful, navigate to the home screen (or dashboard)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminDashScreen())); // Adjust according to your app's routing
    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors
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
                  Icon(Icons.school, color: Colors.white, size: 90,)
                ],
              ),
              const SizedBox(height: 35,),
              // Username TextField
              TextField(
                   style: TextStyle(color: Colors.white),
                controller: _userNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: Colors.white,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  hintText: "Username",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 25,),
              // Password TextField
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;  // Toggle visibility
                      });
                    },
                    icon: isVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Password",
                 
                ),
              ),
              const SizedBox(height: 25,),
              // Submit Button
              GestureDetector(
                onTap: signIN,  // Call the signIN method when tapped
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
                      style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
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
