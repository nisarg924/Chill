import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/core/models/story_model.dart';

class PostRepository {
  final _col = FirebaseFirestore.instance.collection('posts');

  Stream<List<ModelPost>> watchAllExcept(String currentUserId) {
    return _col
        .where('userId', isNotEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ModelPost.fromDocument).toList());
  }
}

class StoryRepository {
  final _col = FirebaseFirestore.instance.collection('stories');

  Stream<List<ModelStory>> watchAll() {
    return _col
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ModelStory.fromDocument).toList());
  }
}
