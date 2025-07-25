import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_todo/core/utils/ui_helpers.dart';
import 'package:my_todo/domain/entities/todo_entity.dart';
import 'package:my_todo/domain/interfaces/firebase_rtdb.dart';
import 'package:my_todo/injcetion/locator.dart';

import '../../widget/todo_item_title.dart';

class Cloud extends StatelessWidget {
  Cloud({super.key});
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final _rtdb = locator<FirebaseRealTimeDataBase>();
  @override
  Widget build(BuildContext context) {
    debugPrint("${userId} userId");
    return Scaffold(
      appBar: AppBar(title: Text("Cloud")),
      body: StreamBuilder<List<Todo>>(
        stream: _rtdb.getTodosStream(userId: userId??""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Xatolik: ${snapshot.error}"));
          }

          final todos = snapshot.data ?? [];

          if (todos.isEmpty) {
            return const Center(child: Text("Hozircha hech narsa yo‘q"));
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final item = todos[index];
              return Builder(
                builder: (context) {
                  return Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: TodoItemTile(
                      title: 'Title ${item.title ?? ''}',
                      time: "start ${item.startTime}",
                      onEdit: () {},
                      onDelete: () async{
                        deleteTodoDialog(id: item.id, context: context, onTap: ()async{
                          _rtdb.deleteTodo(item.id);
                        //  context.pop();
                        });
                      },
                    ),
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}
