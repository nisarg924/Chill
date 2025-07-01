import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/feature/home/home_screen.dart';

import '../../core/constants/const.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ValueNotifier<bool> isStoryMode = ValueNotifier<bool>(false);
  final TextEditingController _captionController = TextEditingController();
  XFile? _pickedImage;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        _pickedImage = file;
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: \$e')),
      );
    }
  }

  Future<void> _uploadContent() async {
    if (_pickedImage == null && _captionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add an image or caption')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      String? imageUrl;
      if (_pickedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child(isStoryMode.value ? 'stories' : 'posts')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = await storageRef.putFile(File(_pickedImage!.path));
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      final data = <String, dynamic>{
        'userId': uid,
        'caption': _captionController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'likes': <String>[],
      };
      if (imageUrl != null) data['imageUrl'] = imageUrl;

      final collection = isStoryMode.value ? 'stories' : 'posts';
      await FirebaseFirestore.instance.collection(collection).add(data);

      // Show toast
      Const.toastSuccess('${isStoryMode.value ? 'Story' : 'Post'} published successfully');

      // Navigate back to home, replacing this screen
      if (mounted) {
        navigateToPage(HomeScreen());
      }
    } catch (e) {
      Const.toastFail('Publish failed: \$e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  void dispose() {
    isStoryMode.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Content')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isStoryMode,
              builder: (context, story, _) {
                return Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Post'),
                      selected: !story,
                      onSelected: (_) => isStoryMode.value = false,
                    ),
                    const SizedBox(width: 10),
                    ChoiceChip(
                      label: const Text('Story'),
                      selected: story,
                      onSelected: (_) => isStoryMode.value = true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  image: _pickedImage != null
                      ? DecorationImage(
                    image: FileImage(File(_pickedImage!.path)),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _pickedImage == null
                    ? const Center(
                  child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                labelText: 'Caption (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadContent,
              child: _isUploading
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Text(isStoryMode.value ? 'Publish Story' : 'Publish Post'),
            ),
          ],
        ),
      ),
    );
  }
}
