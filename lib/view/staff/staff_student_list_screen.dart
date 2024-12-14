import 'package:flutter/material.dart';

class StaffStudentListScreen extends StatefulWidget {
  const StaffStudentListScreen({super.key});

  @override
  State<StaffStudentListScreen> createState() => _StaffStudentListScreenState();
}

class _StaffStudentListScreenState extends State<StaffStudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "STUDENT LIST SCREEN",
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    );
  }
}
