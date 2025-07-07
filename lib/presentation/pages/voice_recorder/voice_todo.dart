import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:my_todo/presentation/pages/home/home_page.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:uuid/uuid.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../../l10n/app_localizations.dart';
List todoList=[];
class VoiceRecorder extends StatefulWidget {
  const VoiceRecorder({super.key});

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isListeningTitle = false;
  bool _isListeningDescription = false;

  @override
  void dispose() {
    _speech.stop();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _startListeningTitle() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListeningTitle = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _titleController.text = val.recognizedWords;
          });
        },
      );
    }
  }

  Future<void> _startListeningDescription() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListeningDescription = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _descriptionController.text = val.recognizedWords;
          });
        },
      );
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListeningTitle = false;
      _isListeningDescription = false;
    });
  }

  Future<void> _saveTodo() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("${AppLocalizations.of(context)?.inputError}"),
        ),
      );
      return;
    }

    final todo = Todo(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrls: null,
      uploadToCloud: false,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
    );
    todoList.add(todo);
    final box = Hive.box<Todo>('todos');
    await box.put(todo.id, todo);

    if (mounted) {
      context.pop(); // Back to HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        //appBar: AppBar(title:  Text("${AppLocalizations.of(context)?.createTodoVoice}")),
        floatingActionButton: FloatingActionButton(
          onPressed: _stopListening,
          backgroundColor: Colors.red,
          child: const Icon(Icons.stop),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isListeningTitle ? Icons.stop : Icons.mic),
                    onPressed: _isListeningTitle
                        ? _stopListening
                        : _startListeningTitle,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                '  ${AppLocalizations.of(context)?.description}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isListeningDescription ? Icons.stop : Icons.mic,
                    ),
                    onPressed: _isListeningDescription
                        ? _stopListening
                        : _startListeningDescription,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      Color(0xFF9747FF),
                    ),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  onPressed: _saveTodo,
                  child: Text(
                    '${AppLocalizations.of(context)?.save}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
