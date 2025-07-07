import 'package:hive/hive.dart';

part 'todo_entity.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String>? imageUrls;

  @HiveField(4)
  final bool uploadToCloud;
  @HiveField(5)
  final DateTime startTime;
  @HiveField(6)
  final DateTime endTime;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrls,
    required this.uploadToCloud,
    required this.startTime,
    required this.endTime
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? imageUrls,
    bool? uploadToCloud,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      uploadToCloud: uploadToCloud ?? this.uploadToCloud,

     startTime:  startTime?? this.startTime, endTime: endTime?? this.endTime,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'imageUrls': imageUrls,
    'uploadToCloud': uploadToCloud,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    imageUrls: json['imageUrls'] != null
        ? List<String>.from(json['imageUrls'])
        : null,
    uploadToCloud: json['uploadToCloud'] ?? false,
    startTime: DateTime.parse(json['startTime']),
    endTime: DateTime.parse(json['endTime']),
  );
}
