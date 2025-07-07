import 'package:bloc/bloc.dart';

import '../../../domain/entities/todo_entity.dart';
import '../../../domain/interfaces/firebase_rtdb.dart';
import '../../../injcetion/locator.dart';

class TodoCubit extends Cubit<void> {
  final FirebaseRealTimeDataBase firebaseService = locator<FirebaseRealTimeDataBase>();

  TodoCubit() : super(null);

  Future<void> upload(Todo todo) async {
    await firebaseService.uploadTodo(todo);
  }
}
