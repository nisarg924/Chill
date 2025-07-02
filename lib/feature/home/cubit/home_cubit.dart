import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/post_model.dart';
import '../../../core/models/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/story_model.dart';
import 'dart:async';

class HomeCubit extends Cubit<HomeState> {
  final PostRepository _postRepo;
  final StoryRepository _storyRepo;

  StreamSubscription<List<ModelPost>>? _postSub;
  StreamSubscription<List<ModelStory>>? _storySub;

  bool _gotPosts = false;
  bool _gotStories = false;

  HomeCubit(this._postRepo, this._storyRepo) : super(const HomeState()) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      emit(state.copyWith(error: "User not logged in", loading: false));
    } else {
      _listen(uid);
    }
  }

  void _listen(String uid) {
    // Posts (excluding self)
    _postSub = _postRepo.watchAllExcept(uid).listen(
          (posts) {
        _gotPosts = true;
        emit(state.copyWith(
          posts: posts,
          loading: !(_gotPosts && _gotStories),
        ));
      },
      onError: (e) => emit(state.copyWith(error: e.toString(), loading: false)),
    );

    // Stories (all users)
    _storySub = _storyRepo.watchAll().listen(
          (stories) {
        _gotStories = true;
        emit(state.copyWith(
          stories: stories,
          loading: !(_gotPosts && _gotStories),
        ));
      },
      onError: (e) => emit(state.copyWith(error: e.toString(), loading: false)),
    );
  }

  @override
  Future<void> close() {
    _postSub?.cancel();
    _storySub?.cancel();
    return super.close();
  }
}


// home_state.dart

class HomeState extends Equatable {
  final List<ModelPost> posts;
  final List<ModelStory> stories;
  final String? error;
  final bool loading;

  const HomeState({
    this.posts = const [],
    this.stories = const [],
    this.error,
    this.loading = true,
  });

  HomeState copyWith({
    List<ModelPost>? posts,
    List<ModelStory>? stories,
    String? error,
    bool? loading,
  }) {
    return HomeState(
      posts: posts ?? this.posts,
      stories: stories ?? this.stories,
      error: error,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [posts, stories, error, loading];
}

class HomeLoading extends HomeState {
  const HomeLoading() : super(loading: true);
}

class HomeError extends HomeState {
  const HomeError(String message) : super(error: message, loading: false);
}
