class Post {
  String id;
  String title;
  String content;
  String writer;
  String imageUrl;
  DateTime createAt;

  Post(
      {required this.id,
      required this.title,
      required this.content,
      required this.writer,
      required this.imageUrl,
      required this.createAt});

  // 1. fromJson 네임드 생성자 만들기
  Post.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id'],
          title: map['title'],
          content: map['content'],
          writer: map['writer'],
          imageUrl: map['imageUrl'],
          createAt: DateTime.parse(map['createAt']),
        );
  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'writer': writer,
      'imageUrl': imageUrl,
      'createAt': createAt.toIso8601String(),
    };
  }
}
