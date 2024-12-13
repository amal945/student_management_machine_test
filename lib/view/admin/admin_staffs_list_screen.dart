import 'package:flutter/material.dart';

class AdminStaffsListScreen extends StatefulWidget {
  const AdminStaffsListScreen({super.key});

  @override
  State<AdminStaffsListScreen> createState() => _AdminStaffsListScreenState();
}

class _AdminStaffsListScreenState extends State<AdminStaffsListScreen> {
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
        backgroundColor: Colors.black,
      body: Center(
        child: Text("STAFF LIST",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}