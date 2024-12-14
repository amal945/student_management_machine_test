import 'package:flutter/material.dart';

class FeesHistoryScreen extends StatefulWidget {
  const FeesHistoryScreen({super.key});

  @override
  State<FeesHistoryScreen> createState() => _FeesHistoryScreenState();
}

class _FeesHistoryScreenState extends State<FeesHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "No fees history",
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    );
  }
}
