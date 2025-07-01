import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/core/models/user_model.dart';

class PostDetailScreen extends StatelessWidget {
  final ModelPost post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(post.userId).get(),
        builder: (context, userSnap) {
          if (!userSnap.hasData) return const Center(child: CircularProgressIndicator());
          final user = ModelUser.fromJson(userSnap.data!.data() as Map<String, dynamic>);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.profileImageUrl != null ? NetworkImage(user.profileImageUrl!) : null,
                  ),
                  title: Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_timeAgo(post.createdAt))
              ),
              if (post.imageUrl != null)
                Image.network(post.imageUrl!, width: double.infinity, fit: BoxFit.cover),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    _LikeButton(post: post, currentUserId: uid),
                    const SizedBox(width: 16),
                    IconButton(icon: const Icon(Icons.comment_outlined), onPressed: () {}),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('${post.likes.length} likes', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(text: user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' '),
                      TextSpan(text: post.caption),
                    ],
                  ),
                ),
              ),

              const Divider(),
              Expanded(
                child: CommentsSection(postId: post.id),
              ),

              _CommentInput(postId: post.id, currentUserId: uid),
            ],
          );
        },
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

class _LikeButton extends StatefulWidget {
  final ModelPost post;
  final String? currentUserId;
  const _LikeButton({required this.post, this.currentUserId});

  @override
  State<_LikeButton> createState() => __LikeButtonState();
}

class __LikeButtonState extends State<_LikeButton> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.likes.contains(widget.currentUserId);
  }

  Future<void> _toggleLike() async {
    final uid = widget.currentUserId;
    if (uid == null) return;
    final postRef = FirebaseFirestore.instance.collection('posts').doc(widget.post.id);
    if (_isLiked) {
      await postRef.update({'likes': FieldValue.arrayRemove([uid])});
    } else {
      await postRef.update({'likes': FieldValue.arrayUnion([uid])});
    }
    setState(() => _isLiked = !_isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border,
          color: _isLiked ? Colors.red : null),
      onPressed: _toggleLike,
    );
  }
}

class CommentsSection extends StatelessWidget {
  final String postId;
  const CommentsSection({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        final comments = snap.data!.docs;
        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, i) {
            final data = comments[i].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['username'] ?? 'User'),
              subtitle: Text(data['text'] ?? ''),
            );
          },
        );
      },
    );
  }
}

class _CommentInput extends StatefulWidget {
  final String postId;
  final String? currentUserId;
  const _CommentInput({required this.postId, this.currentUserId});

  @override
  State<_CommentInput> createState() => __CommentInputState();
}

class __CommentInputState extends State<_CommentInput> {
  final TextEditingController _ctrl = TextEditingController();
  bool _isSending = false;

  Future<void> _sendComment() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty || widget.currentUserId == null) return;
    setState(() => _isSending = true);
    final commentData = {
      'userId': widget.currentUserId,
      'username': FirebaseAuth.instance.currentUser?.displayName ?? '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .add(commentData);
    _ctrl.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                decoration: const InputDecoration(
                  hintText: 'Add a comment...',
                  border: InputBorder.none,
                ),
              ),
            ),
            _isSending
                ? const CircularProgressIndicator()
                : IconButton(
              icon: const Icon(Icons.send),
              onPressed: _sendComment,
            ),
          ],
        ),
      ),
    );
  }
}
