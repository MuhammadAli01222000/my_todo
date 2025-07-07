

import 'package:my_todo/domain/entities/todo_entity.dart';

import '../../domain/interfaces/cloud.dart';

class CloudServiceImpl implements CloudRepository{
  @override
  Future<void> createTodo(Todo todo) {
    // TODO: implement createTodo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(String id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> readTodos() {
    // TODO: implement readTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
  
}