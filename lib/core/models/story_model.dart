import 'package:cloud_firestore/cloud_firestore.dart';

class ModelStory {
  final String id;
  final String userId;
  final String? imageUrl;
  final String? caption;
  final DateTime createdAt;

  ModelStory({
    required this.id,
    required this.userId,
    this.imageUrl,
    this.caption,
    required this.createdAt,
  });

  factory ModelStory.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return ModelStory(
      id: doc.id,
      userId: json['userId'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      caption: json['caption'] as String?,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'imageUrl': imageUrl,
    'caption': caption,
    'createdAt': FieldValue.serverTimestamp(),
  };
}
