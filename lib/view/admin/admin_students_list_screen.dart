import 'package:flutter/material.dart';

class AdminStudentsListScreen extends StatefulWidget {
  const AdminStudentsListScreen({super.key});

  @override
  State<AdminStudentsListScreen> createState() => _AdminStudentsListScreenState();
}

class _AdminStudentsListScreenState extends State<AdminStudentsListScreen> {
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("STUDENTS LIST",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}