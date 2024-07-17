import 'dart:convert';

class ContentModel {
  final int? id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String userId;
  final int? parentId;
  Map<String, dynamic>? content;
  final bool isFolder;
  final int level;

  ContentModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.userId,
      required this.parentId,
      required this.content,
      required this.isFolder,
      required this.level});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      content: null,
      isFolder: json['is_folder'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson({bool isForAdd = false}) {
    final Map<String, dynamic> data = {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'name': name,
      'user_id': userId,
      'parent_id': parentId,
      'content': content,
      'is_folder': isFolder,
    };
    if (isForAdd) {
      data.remove('id');
    }
    return data;
  }
}
