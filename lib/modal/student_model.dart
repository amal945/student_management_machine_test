class StudentModel {
  final String id;
  final String email;
  final String role;
  final String name;

  StudentModel(
      {required this.id,
      required this.email,
      required this.role,
      required this.name});

  factory StudentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StudentModel(
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
