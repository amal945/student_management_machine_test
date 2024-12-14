class StaffModel {
  final String id;
  final String email;
  final String role;
  final String name;

  // Constructor
  StaffModel({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
  });


  factory StaffModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StaffModel(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }
}

