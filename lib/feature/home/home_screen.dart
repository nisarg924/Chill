import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/post_model.dart';
import '../../core/models/repository.dart';
import '../../core/models/story_model.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(PostRepository(), StoryRepository()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Chill'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.loading) return Center(child: CircularProgressIndicator());
            if (state.error != null) return Center(child: Text(state.error!));

            return CustomScrollView(
              slivers: [
                // Stories
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: state.stories.length,
                      itemBuilder: (ctx, i) => _StoryItem.story(state.stories[i]),
                    ),
                  ),
                ),
                // Posts
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (ctx, i) => _PostCard.post(state.posts[i]),
                    childCount: state.posts.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final ModelStory story;
  const _StoryItem.story(this.story);

  @override
  Widget build(BuildContext context) {
    // You can fetch the user’s avatar via a FutureBuilder on the user collection
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(story.imageUrl ?? ''),
          ),
          SizedBox(height: 6),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(story.userId)
                .get(),
            builder: (_, snap) {
              if (!snap.hasData) return SizedBox();
              return Text(
                (snap.data!['username'] as String?) ?? '',
                style: TextStyle(fontSize: 14),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final ModelPost post;
  const _PostCard.post(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(post.userId).get(),
          builder: (_, snap) {
            final user = snap.hasData ? (snap.data!) : null;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user != null
                    ? NetworkImage(user['profileImageUrl'] ?? '')
                    : null,
              ),
              title: Text(user?['username'] ?? ''),
              subtitle: Text(
                timeAgo(post.createdAt),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              trailing: Icon(Icons.more_horiz),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(post.caption),
        ),
        if (post.imageUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.network(post.imageUrl!),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 4),
              Text('${post.likes.length}'),
              SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline),
              SizedBox(width: 4),
              Text('0'),
              Spacer(),
              Icon(Icons.send),
            ],
          ),
        ),
      ],
    );
  }
}

// Simple time-ago helper:
String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inDays >= 1) return '${diff.inDays}d ago';
  if (diff.inHours >= 1 ) return '${diff.inHours}h ago';
  if (diff.inMinutes >= 1 ) return '${diff.inMinutes}m ago';
  return 'Just now';
}
