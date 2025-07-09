
import '../entities/todo_entity.dart';

abstract class FirebaseRealTimeDataBase {
  Future<void> uploadTodo(Todo todo);
  Stream<List<Todo>> getTodosStream({required String userId});
  Future<void> deleteTodo(String id);  // DELETE
  Future<Todo?> getSingleTodo(String title);
}
