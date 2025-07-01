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

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
    'profileImageUrl': profileImageUrl,
    'bio': bio,
    'createdAt': createdAt.toIso8601String(),
  };
}
