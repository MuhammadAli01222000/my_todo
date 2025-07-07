import 'package:hive/hive.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/interfaces/hive_service.dart';

class TodoService implements ITodoService {
  static const String todoBoxName = 'todos';

  Future<Box<Todo>> get _box async => await Hive.openBox<Todo>(todoBoxName);

  @override
  Future<void> writeTodo(Todo todo) async {
    try {
      final box = await _box;
      await box.put(todo.id, todo);
      print('Todo saqlandi: ${todo.title}');
    } catch (e) {
      print('Todo saqlashda xatolik: $e');
      rethrow;
    }
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    try {
      final box = await _box;
      final todos = box.values.toList();
      print('Olingan todo\'lar soni: ${todos.length}');
      return todos;
    } catch (e) {
      print('Todo\'larni olishda xatolik: $e');
      return []; // Xatolik bo'lsa bo'sh ro'yxat qaytarish
    }
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    try {
      final box = await _box;
      final todo = box.get(id);
      print('Todo topildi: ${todo?.title ?? 'topilmadi'}'); // Debug uchun
      return todo;
    } catch (e) {
      print('Todo topishda xatolik: $e');
      return null;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      final box = await _box;
      await box.delete(id);
      print('Todo o\'chirildi: $id'); // Debug uchun
    } catch (e) {
      print('Todo o\'chirishda xatolik: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearAllTodos() async {
    try {
      final box = await _box;
      await box.clear();
      print('Barcha todo\'lar o\'chirildi'); // Debug uchun
    } catch (e) {
      print('Barcha todo\'larni o\'chirishda xatolik: $e');
      rethrow;
    }
  }

  // Qo'shimcha utility metodlar

  // Box ochiq ekanligini tekshirish
  bool get isBoxOpen => Hive.isBoxOpen(todoBoxName);

  // Box ni yopish (ixtiyoriy)
  Future<void> closeBox() async {
    if (isBoxOpen) {
      await Hive.box<Todo>(todoBoxName).close();
    }
  }

  // Todo mavjudligini tekshirish
  Future<bool> todoExists(String id) async {
    try {
      final box = await _box;
      return box.containsKey(id);
    } catch (e) {
      print('Todo mavjudligini tekshirishda xatolik: $e');
      return false;
    }
  }

  // Todo soni
  Future<int> getTodoCount() async {
    try {
      final box = await _box;
      return box.length;
    } catch (e) {
      print('Todo sonini olishda xatolik: $e');
      return 0;
    }
  }
}