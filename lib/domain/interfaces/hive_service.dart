import '../entities/todo_entity.dart';

abstract class ITodoService {
  Future<void> writeTodo(Todo todo);
  Future<List<Todo>> getAllTodos();
  Future<Todo?> getTodoById(String id);
  Future<void> deleteTodo(String id);
  Future<void> clearAllTodos();
}
