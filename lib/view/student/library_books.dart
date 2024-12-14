import 'package:flutter/material.dart';

class LibraryBooksScreen extends StatefulWidget {
  const LibraryBooksScreen({super.key});

  @override
  State<LibraryBooksScreen> createState() => _LibraryBooksScreenState();
}

class _LibraryBooksScreenState extends State<LibraryBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "No books available",
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    );
  }
}
