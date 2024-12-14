import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/constants/constants.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  bool isVisible = false;
  String? selectedValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassord = confirmPasswordController.text.trim();

    if (name.isEmpty) {
      showFailureSnackBar("NAME IS EMPTY", context);
    }
    if (email.isEmpty) {
      showFailureSnackBar("EMAIL IS EMPTY", context);
    }

    if (confirmPassord != password) {
      showFailureSnackBar(
          "password and confirm password is not equal", context);
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      showFailureSnackBar("Enter a valid email address!", context);
      return;
    }
    if (password.isEmpty) {
      showFailureSnackBar("Password is required!", context);
      return;
    }

    if (password.length < 6) {
      showFailureSnackBar("Password is too short", context);
    }
    if (selectedValue == null) {
      showFailureSnackBar("Please select a role!", context);
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection(selectedValue!)
          .doc(userCredential.user?.uid)
          .set({
        "id": userCredential.user?.uid,
        "name": name,
        "email": email,
        "role": selectedValue
      });
      print("User Creation Succsessfull");
      showSuccessSnackBar("User registered successfully!", context);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showFailureSnackBar("This email is already in use.", context);
      } else if (e.code == 'weak-password') {
        showFailureSnackBar("The password is too weak.", context);
      } else {
        showFailureSnackBar(
            e.message ?? "An error occurred. Please try again.", context);
      }
    } catch (e) {
      showFailureSnackBar("An error occurred. Please try again.", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: lightBlack,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined, color: yellow)),
          title: Text(
            "USER REGISTRATION",
            style: TextStyle(color: yellow),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                kHeight25,
                Icon(
                  Icons.school,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 45,
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: "Name"),
                ),
                kHeight25,
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: "Email"),
                ),
                kHeight25,
                TextField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible; // Toggle visibility
                        });
                      },
                      icon: isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Password",
                  ),
                ),
                kHeight25,
                TextField(
                  controller: confirmPasswordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible; // Toggle visibility
                        });
                      },
                      icon: isVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Confirm Password",
                  ),
                ),
                kHeight25,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: black,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 3),
                    child: DropdownButton<String>(
                      iconEnabledColor: yellow,
                      dropdownColor: const Color.fromARGB(255, 151, 148, 148),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      isExpanded: true,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      menuWidth: size.width,
                      value: selectedValue, // Current selected value
                      hint: Text(
                        'Select the Role',
                        style: TextStyle(color: Colors.grey),
                      ), // Placeholder text
                      items: <String>['Staff', 'Student']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue; // Update the selected value
                        });
                      },
                    ),
                  ),
                ),
                kHeight25,
                GestureDetector(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    width: size.width,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                        color: yellow, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "Register User",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
