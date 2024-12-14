import 'package:flutter/material.dart';

class StaffPayementScreen extends StatefulWidget {
  const StaffPayementScreen({super.key});

  @override
  State<StaffPayementScreen> createState() => _StaffPayementScreenState();
}

class _StaffPayementScreenState extends State<StaffPayementScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "PAYMENT HISTORY",
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    );
  }
}
