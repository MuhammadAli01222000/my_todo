import 'package:firebase_database/firebase_database.dart';

import '../../domain/entities/todo_entity.dart';
import '../../domain/interfaces/cloud.dart';

class FirebaseTodoRepository implements CloudRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final String userId;

  FirebaseTodoRepository({required this.userId});

  @override
  Future<void> createTodo(Todo todo) async {
    await _database.ref('todos/$userId/${todo.id}').set(todo.toJson());
  }

  @override
  Future<List<Todo>> readTodos() async {
    final snapshot = await _database.ref('todos/$userId').get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.entries
          .map((e) => Todo.fromJson(Map<String, dynamic>.from(e.value)))
          .toList();
    }
    return [];
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _database.ref('todos/$userId/${todo.id}').update(todo.toJson());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _database.ref('todos/$userId/$id').remove();
  }
}
