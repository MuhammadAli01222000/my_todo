import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../domain/interfaces/firebase_rtdb.dart';

class FirebaseRealTimeDatabaseImpl implements FirebaseRealTimeDataBase {
  final _database = FirebaseDatabase.instance.ref();

  @override
  Future<void> uploadTodo(Todo todo) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _database.child('todos').child(userId).child(todo.id).set({
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'uploadToCloud': todo.uploadToCloud,
      'startTime': todo.startTime.toIso8601String(),
      'endTime': todo.endTime.toIso8601String(),
    });
  }
  /// get id
  @override
  Stream<List<Todo>> getTodosStream({required String userId}) {
    return _database.child('todos').child(userId).onValue.map((event) {
      final data = event.snapshot.value;
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        return map.entries.map((e) {
          final value = Map<String, dynamic>.from(e.value);
          return Todo.fromJson(value);
        }).toList();
      } else {
        return <Todo>[];
      }
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _database.child('todos').child(userId).child(id).remove();
  }

  @override
  Future<Todo?> getSingleTodo(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return null;

    final snapshot = await _database.child('todos').child(userId).child(id).once();
    final data = snapshot.snapshot.value;
    if (data == null) return null;

    final map = Map<String, dynamic>.from(data as Map);
    return Todo.fromJson(map);
  }

}
