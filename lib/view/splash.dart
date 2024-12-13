import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    super.initState();
    navigateToLogin();
  }


void navigateToLogin(){
Future.delayed(const Duration(seconds: 2),(){
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const LoginScreen()),);
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
              Icon(Icons.school,size: 100,color: Colors.white,),
              Text("Student Portal",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}