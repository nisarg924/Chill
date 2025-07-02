import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [];
  Timer? _debounce;
  String _searchQuery = '';
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.addAll(prefs.getStringList('recentSearches') ?? []);
    });
  }

  Future<void> _addToRecentSearches(String query) async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches.remove(query); // avoid duplicates
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 10) _recentSearches.removeLast();
    await prefs.setStringList('recentSearches', _recentSearches);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() => _searchQuery = query.trim());
      if (_searchQuery.isNotEmpty) {
        _addToRecentSearches(_searchQuery);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty) {
      return const Center(child: Text("No recent searches"));
    }

    return ListView.builder(
      itemCount: _recentSearches.length,
      itemBuilder: (context, index) {
        final query = _recentSearches[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(query),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              setState(() => _recentSearches.removeAt(index));
              final prefs = await SharedPreferences.getInstance();
              prefs.setStringList('recentSearches', _recentSearches);
            },
          ),
          onTap: () {
            _searchController.text = query;
            _onSearchChanged(query);
          },
        );
      },
    );
  }

  Widget _buildUserResults(String searchLower) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: searchLower)
          .where('username', isLessThan: searchLower + 'z')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final users = snapshot.data!.docs;
        if (users.isEmpty) return const Center(child: Text('No matching users.'));
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index].data() as Map<String, dynamic>;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['profileImageUrl'] ?? ''),
              ),
              title: Text(user['username'] ?? ''),
              onTap: () {
                // Navigate to user profile
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPostResults(String searchLower) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final posts = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final caption = data['caption']?.toLowerCase() ?? '';
          return caption.contains(searchLower);
        }).toList();

        if (posts.isEmpty) return const Center(child: Text('No matching posts.'));
        return GridView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: posts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final post = posts[index].data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                // Navigate to post
              },
              child: Image.network(
                post['imageUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchLower = _searchQuery.toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Search users or posts',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Posts'),
          ],
        ),
      ),
      body: _searchQuery.isEmpty
          ? _buildRecentSearches()
          : TabBarView(
        controller: _tabController,
        children: [
          _buildUserResults(searchLower),
          _buildPostResults(searchLower),
        ],
      ),
    );
  }
}
