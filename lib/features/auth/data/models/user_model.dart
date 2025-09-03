
import 'package:bodoni/features/auth/domain/auth_domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      name: data['name'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': id,
      'email': email,
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}