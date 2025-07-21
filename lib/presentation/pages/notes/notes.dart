import 'package:flutter/material.dart';
import 'package:my_todo/domain/entities/todo_entity.dart';
import 'package:my_todo/domain/interfaces/hive_service.dart';
import 'package:my_todo/injcetion/locator.dart';

class Notes extends StatefulWidget {
  final Todo? todo;
  const Notes({super.key, this.todo});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final todoService = locator<ITodoService>();

  @override
  void initState() {
    super.initState();
    _controllerDescription.text = widget.todo?.description ?? '';
    _controllerTitle.text = widget.todo?.title ?? '';
  }

  void _saveChanges() async {
    if (_controllerTitle.text.trim().isEmpty ||
        _controllerDescription.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title va Description to'ldirilishi kerak"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.todo != null) {
      final updatedTodo = Todo(
        id: widget.todo!.id,
        title: _controllerTitle.text.trim(),
        description: _controllerDescription.text.trim(),
        imageUrls: widget.todo!.imageUrls,
        uploadToCloud: widget.todo!.uploadToCloud,
        startTime: widget.todo!.startTime,
        endTime: widget.todo!.endTime,
      );

      await todoService.writeTodo(updatedTodo);
      Navigator.pop(context, updatedTodo); // optional
    } else {
      // Yangi todo yaratmoqchi bo'lsangiz shu yerga qo'shasiz
    }
  }

  @override
  void dispose() {
    _controllerDescription.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _saveChanges,
        child: const Icon(Icons.check),
      ),
      appBar: AppBar(title: Text(widget.todo?.title ?? 'Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controllerTitle,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _controllerDescription,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
