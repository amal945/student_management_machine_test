import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_management/view/admin/register_user_page.dart';
import 'package:student_management/constants/constants.dart';
import 'package:student_management/view/staff/staff_student_list_screen.dart';
import 'package:student_management/view/student/fees_history_screen.dart';
import 'package:student_management/view/student/library_books.dart';

import '../login screen/login_screen.dart';
import 'staff_payement_screen.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  int currentIndex = 0;

  // Make sure this list is within range and no out of bounds error occurs
  tabSwitch(int index) {
    setState(() {
      // Ensure the index is within the valid range
      if (index >= 0 && index < screens.length) {
        currentIndex = index;
      }
    });
  }

  final List<Widget> screens = [
    StaffStudentListScreen(),
    LibraryBooksScreen(),
    StaffPayementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: lightBlack,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Container(
                  height: size.height / 11,
                  width: size.width / 5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.yellow,
                  ),
                  child: const Center(
                    child: Text(
                      "A",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "USERNAME",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: const ListTile(
                        title: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterUserPage()));
        },
        label: Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
      body: screens[currentIndex], // This will be safe now
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: lightBlack,
              boxShadow: [
                BoxShadow(offset: Offset(0, 4), color: Colors.black26)
              ]),
          child: GNav(
            padding: EdgeInsets.all(16),
            gap: 18,
            tabs: [
              GButton(
                icon: Icons.person,
                iconSize: 30,
                text: 'Students',
                textColor: Colors.yellow,
                iconActiveColor: Colors.yellow,
                iconColor: Colors.yellow,
              ),
              GButton(
                icon: Icons.library_books,
                iconSize: 30,
                text: 'Library',
                textColor: Colors.yellow,
                iconActiveColor: Colors.yellow,
                iconColor: Colors.yellow,
              ),
              GButton(
                icon: Icons.money,
                iconSize: 30,
                text: 'Payment',
                textColor: Colors.yellow,
                iconActiveColor: Colors.yellow,
                iconColor: Colors.yellow,
              ),
            ],
            selectedIndex: currentIndex,
            onTabChange: tabSwitch,
          ),
        ),
      ),
    );
  }
}
