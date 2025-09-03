



import 'package:bodoni/features/checklist/domain/entitites/checklist_item.dart';

class ChecklistItemModel extends ChecklistItem {
  const ChecklistItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
    super.completedAt,
  });

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}