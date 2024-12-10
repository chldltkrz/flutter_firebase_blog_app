// 1. 상태 클래스 만들기
import 'dart:io';

import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class WriteState {
  bool isWriting;
  String? imageUrl;
  WriteState(this.isWriting, this.imageUrl);
}
// 2. viewmoderl 만들기

class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  @override
  WriteState build(Post? arg) {
    return WriteState(false, null);
  }

  Future<bool> insert(
      {required String writer,
      required String title,
      required String content}) async {
    final postRepository = PostRepository();
    state = WriteState(true, state.imageUrl);
    // 포스트 객체가 null이면 새로작ㅈ성
    if (state.imageUrl == null) {
      return false;
    }

    if (arg == null) {
      final result = await postRepository.insert(
          writer: writer,
          title: title,
          content: content,
          imageUrl: state.imageUrl!);
      Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);

      return result;
      // null 이 아니면 업데이트
    } else {
      final result = await postRepository.update(
          id: arg!.id,
          writer: writer,
          title: title,
          content: content,
          imageUrl: state.imageUrl!);
      Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);
      return result;
    }
  }

  void uploadImage(XFile file) async {
    try {
      // 1. firebase Storage객체 가지고 오기
      final storage = FirebaseStorage.instance;
      // 2. firebase Storage 참조 만들기
      Reference ref = storage.ref();
      // 3. 파일 참조 만들기
      Reference fileRef = ref
          .child('${DateTime.now().millisecondsSinceEpoch}_${file.name}.png');
      // 4. 쓰기
      await fileRef.putFile(File(file.path));
      // 5. 파일에 접근할수 있는 url 받기
      final imageUrl = await fileRef.getDownloadURL();
      state = WriteState(state.isWriting, imageUrl);
    } catch (e) {
      print(e);
    }
  }
}

// 3. 뷰모델 관리자 만들기
final writeViewModelProvider =
    NotifierProvider.autoDispose.family<WriteViewModel, WriteState, Post?>(() {
  return WriteViewModel();
});
