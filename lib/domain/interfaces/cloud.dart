import '../entities/todo_entity.dart';

abstract class CloudRepository {
  Future<void> createTodo(Todo todo);
  Future<List<Todo>> readTodos();
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
