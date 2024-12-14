import 'dart:ui';

import 'package:flutter/material.dart';

final lightBlack = const Color.fromARGB(255, 40, 40, 40);
final yellow = Colors.yellow;
final black = Colors.black;

final kHeight55 = SizedBox(height: 55);
final kHeight25 = SizedBox(
  height: 25,
);



showSuccessSnackBar(
  String message,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.done,
              color: Color.fromARGB(255, 66, 239, 83),
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}

showFailureSnackBar(
  String message,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const Icon(
              Icons.cancel,
              size: 28,
              color: Colors.red,
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}