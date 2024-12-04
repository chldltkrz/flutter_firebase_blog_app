import 'dart:async';

import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 1. 상태 클래스 만들기
// List<Post>를 상태로 사용 가능

// 2. 뷰모델 만들기

class HomeViewModel extends Notifier<List<Post>> {
  @override
  List<Post> build() {
    getAllPosts();
    return [];
  }

  Future<void> getAllPosts() async {
    final postRepo = PostRepository();
    // final posts = await postRepo.getAll();
    // state = posts ?? [];
    final stream = postRepo.postListStream();
    final streamSubscription = stream.listen((event) {
      state = event;
    });

    /// viewModel이 사라질때 넘겨준 함수 호출
    ref.onDispose(() {
      /// 구독을 끊어야 메모리에서 제거됨
      streamSubscription.cancel();
    });
  }
}

// 3. 뷰모델 관리자 만들기
final homeViewModelProvider = NotifierProvider<HomeViewModel, List<Post>>(() {
  return HomeViewModel();
});
