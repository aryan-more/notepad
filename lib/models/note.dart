import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final DateTime createdDate;
  DateTime lastUpdateDate;
  String title;
  String content;
  Note({
    required this.createdDate,
    required this.lastUpdateDate,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdDate': createdDate.millisecondsSinceEpoch,
      'lastUpdateDate': lastUpdateDate.millisecondsSinceEpoch,
      'title': title,
      'content': content,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return <String, dynamic>{
      'lastUpdateDate': DateTime.now().millisecondsSinceEpoch,
      'title': title,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      lastUpdateDate: DateTime.fromMillisecondsSinceEpoch(map['lastUpdateDate'] as int),
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  factory Note.createNew({
    required String title,
    required String content,
  }) {
    return Note(
      createdDate: DateTime.now(),
      lastUpdateDate: DateTime.now(),
      title: title,
      content: content,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  void applyUpdate({
    required String title,
    required String content,
  }) {
    lastUpdateDate = DateTime.now();
    this.title = title;
    this.content = content;
  }
}
