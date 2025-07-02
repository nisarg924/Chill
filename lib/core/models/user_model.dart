import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? bio;
  final DateTime createdAt;

  ModelUser({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    required this.createdAt,
  });

  factory ModelUser.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return ModelUser(
      id: doc.id,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      bio: json['bio'] as String?,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
    'profileImageUrl': profileImageUrl,
    'bio': bio,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
