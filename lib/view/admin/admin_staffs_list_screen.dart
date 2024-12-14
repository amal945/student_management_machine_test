import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management/modal/staff_model.dart';
import 'package:student_management/constants/constants.dart';

class AdminStaffsListScreen extends StatefulWidget {
  const AdminStaffsListScreen({super.key});

  @override
  State<AdminStaffsListScreen> createState() => _AdminStaffsListScreenState();
}

class _AdminStaffsListScreenState extends State<AdminStaffsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Staff")
                .where("role", isEqualTo: "Staff")
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshots.hasError) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              }
              if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                return const Center(
                  child: Text("NONE FOUND"),
                );
              }

              List<StaffModel> staffData = snapshots.data!.docs.map((doc) {
                return StaffModel.fromMap(
                    doc.data() as Map<String, dynamic>, doc.id);
              }).toList();

              return ListView.builder(
                  itemCount: staffData.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final data = staffData[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlack,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          textColor: Colors.white,
                          trailing: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          title: Text(
                            data.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  });
            }
            )
            );
  }
}
