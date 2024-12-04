import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 1. 상태 클래스 만들기
// post 객체 사용할거라 만들지 않음

// 2. 뷰 모델 만들기

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  final postRepository = PostRepository();

  @override
  Post build(Post arg) {
    listenStream();
    return arg;
  }

  Future<bool> deletePost() async {
    final postRepository = PostRepository();
    return postRepository.delete(arg.id);
  }

  void listenStream() {
    final stream = postRepository.postStream(arg.id);
    final streamSubscription = stream.listen((event) {
      if (event != null) {
        state = event;
      }
    });

    ref.onDispose(() {
      streamSubscription.cancel();
    });
  }
}

// 3. 뷰모델 관리자 만들기
final detailViewModelProvider =
    NotifierProvider.autoDispose.family<DetailViewModel, Post, Post>(() {
  return DetailViewModel();
});
