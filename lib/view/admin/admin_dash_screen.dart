import 'package:flutter/material.dart';
import 'package:student_management/view/admin/admin_staffs_list_screen.dart';
import 'package:student_management/view/admin/admin_students_list_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminDashScreen extends StatefulWidget {
  const AdminDashScreen({super.key});

  @override
  State<AdminDashScreen> createState() => _AdminDashScreenState();
}

class _AdminDashScreenState extends State<AdminDashScreen> {

  int currentIndex = 0;

tabSwitch(int index){
setState(() {
  currentIndex = index;
});
}


final List<Widget> screens = [
  AdminStudentsListScreen(),
  AdminStaffsListScreen(),
];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Icon(Icons.add),backgroundColor: Colors.yellow,),
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
          
            color: const Color.fromARGB(255, 40, 40, 40),
             boxShadow: [
              BoxShadow(
                offset: Offset(0, 4)
                ,color: Colors.black26
              )
             ]
          ),
        
          child: GNav(
            gap: 18,
            tabs:  [
            GButton(icon: Icons.person,iconSize: 35,text:  'Students',textColor: Colors.yellow,iconActiveColor: Colors.yellow,iconColor: Colors.yellow,),
            GButton(icon: Icons.woman_2,iconSize:35, text: 'Staffs',textColor: Colors.yellow,iconActiveColor: Colors.yellow,iconColor: Colors.yellow,)
          ],
          selectedIndex: currentIndex,
          onTabChange: tabSwitch,
          ),
        ),
      ),
    );
    
  }
}