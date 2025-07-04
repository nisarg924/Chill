import 'package:cloud_firestore/cloud_firestore.dart';

class ModelPost {
  final String id;
  final String userId;
  final String caption;
  final String? imageUrl;
  final List<String> likes;
  final DateTime createdAt;

  ModelPost({
    required this.id,
    required this.userId,
    required this.caption,
    this.imageUrl,
    required this.likes,
    required this.createdAt,
  });

  factory ModelPost.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return ModelPost(
      id: doc.id,
      userId: json['userId'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      likes: List<String>.from(json['likes'] ?? []),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'caption': caption,
    'imageUrl': imageUrl,
    'likes': likes,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
