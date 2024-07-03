import 'dart:convert';

class ContentModel {
  final int? id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String userId;
  final int? childId;
  Map<String, dynamic>? content;
  final bool isFolder;
  List<ContentModel>? children;

  ContentModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.userId,
      required this.childId,
      required this.content,
      required this.isFolder,
      this.children});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'],
      userId: json['user_id'],
      childId: json['child_id'],
      content: json['content'],
      isFolder: json['is_folder'],
      children: [],
    );
  }

  Map<String, dynamic> toJson({bool isForAdd = false}) {
    final Map<String, dynamic> data = {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'name': name,
      'user_id': userId,
      'child_id': childId,
      'content': content,
      'is_folder': isFolder,
    };
    if (isForAdd) {
      data.remove('id');
    }
    return data;
  }
}
