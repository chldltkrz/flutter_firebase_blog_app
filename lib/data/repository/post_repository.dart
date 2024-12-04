import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';

class PostRepository {
  Future<List<Post>?> getAll() async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3. 값 불러오기
      final result = await collectionRef.get();

      // 4. 값 가져오기
      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return Post.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 1. Create
  Future<bool> insert(
      {required String title,
      required String content,
      required String writer,
      required String imageUrl}) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3. 문서참조 만들기
      final docRef = collectionRef.doc();
      // 4. 값 쓰기
      await docRef.set({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
        'createAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 2. Read
  Future<Post?> getOne(String id) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3. 문서참조 만들기
      final docRef = collectionRef.doc(id);
      // 4. 값 불러오기
      final doc = await docRef.get();
      return Post.fromJson(
        {'id': doc.id, ...doc.data()!},
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 3. Update
  Future<bool> update(
      {required String id,
      required String writer,
      required String title,
      required String imageUrl,
      required String content}) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3. 문서참조 만들기
      final docRef = collectionRef.doc(id);
      // 4. 값 업데이트
      // update 와 set의 차이점 -> set은 도큐먼트가 없으면 생성함
      await docRef.update({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // 4. Delete
  Future<bool> delete(String id) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3. 문서참조 만들기
      final docRef = collectionRef.doc(id);
      // 4. 값 삭제
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Post>> postListStream() {
    final firestore = FirebaseFirestore.instance;
    final collectionRef =
        firestore.collection('posts').orderBy('createAt', descending: true);
    final stream = collectionRef.snapshots();

    // List<Post> 형태로 변경
    final newStream = stream.map((event) {
      return event.docs.map((e) {
        return Post.fromJson({
          'id': e.id,
          ...e.data(),
        });
      }).toList();
    });
    return newStream;
  }

  Stream<Post?> postStream(String id) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('posts');
    final docRef = collectionRef.doc(id);
    final stream = docRef.snapshots();
    final newstream = stream.map(
      (event) {
        if (event.data() == null) {
          return null;
        }
        return Post.fromJson({
          'id': event.id,
          ...event.data()!,
        });
      },
    );
    return newstream;
  }
}
