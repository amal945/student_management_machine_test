import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/view/admin/admin_staffs_list_screen.dart';
import 'package:student_management/view/admin/admin_students_list_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_management/view/admin/register_user_page.dart';
import 'package:student_management/constants/constants.dart';
import 'package:student_management/view/login%20screen/login_screen.dart';

class AdminDashScreen extends StatefulWidget {
  const AdminDashScreen({super.key});

  @override
  State<AdminDashScreen> createState() => _AdminDashScreenState();
}

class _AdminDashScreenState extends State<AdminDashScreen> {
  int currentIndex = 0;

  tabSwitch(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> screens = [
    const AdminStudentsListScreen(),
    const AdminStaffsListScreen(),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegisterUserPage()));
        },
        label: const Icon(Icons.add),
        backgroundColor: Colors.yellow,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: lightBlack,
              boxShadow: const [
                BoxShadow(offset: Offset(0, 4), color: Colors.black26)
              ]),
          child: GNav(
            padding: EdgeInsets.all(16),
            gap: 18,
            tabs: const [
              GButton(
                icon: Icons.person,
                iconSize: 35,
                text: 'Students',
                textColor: Colors.yellow,
                iconActiveColor: Colors.yellow,
                iconColor: Colors.yellow,
              ),
              GButton(
                icon: Icons.woman_2,
                iconSize: 35,
                text: 'Staffs',
                textColor: Colors.yellow,
                iconActiveColor: Colors.yellow,
                iconColor: Colors.yellow,
              )
            ],
            selectedIndex: currentIndex,
            onTabChange: tabSwitch,
          ),
        ),
      ),
    );
  }
}
