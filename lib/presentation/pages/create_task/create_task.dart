import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/presentation/bloc/cubit/microphone_cubit.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/rtdb_service.dart';
import '../../../core/services/voice_service_impl.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../../domain/interfaces/firebase_rtdb.dart';
import '../../../domain/interfaces/voice_service.dart';
import '../../../injcetion/locator.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/cubit/cloud_switch_button.dart';

// gey language code
String _getLanguageCodeFromContext(BuildContext context) {
  final locale = Localizations.localeOf(context);
  switch (locale.languageCode) {
    case 'uz':
      return 'uz-UZ';
    case 'ru':
      return 'ru-RU';
    case 'en':
    default:
      return 'en-US';
  }
}

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final voiceService = locator<VoiceServiceImpl>();

  bool _isListeningTitle = false;
  bool _isListeningDescription = false;

  DateTime? _pickedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  void dispose() {
    voiceService.stopListening();
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _startListeningTitle() async {
    final langCode = _getLanguageCodeFromContext(context);
    await voiceService.startListening(
      onResult: (text) {
        if (!mounted) return;
        setState(() {
          _titleController.text = text;
          _isListeningTitle = true;
        });
      },
      languageCode: langCode,
    );
  }

  Future<void> _startListeningDescription() async {
    final langCode = _getLanguageCodeFromContext(context);
    await voiceService.startListening(
      onResult: (text) {
        if (!mounted) return;
        setState(() {
          _descriptionController.text = text;
          _isListeningDescription = true;
        });
      },
      languageCode: langCode,
    );
  }

  Future<void> _speakTitle() async {
    final langCode = _getLanguageCodeFromContext(context);
    await voiceService.speak(_titleController.text, languageCode: langCode);
  }

  Future<void> _speakDescription() async {
    final langCode = _getLanguageCodeFromContext(context);
    await voiceService.speak(
      _descriptionController.text,
      languageCode: langCode,
    );
  }

  /// date time
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _pickedDate = picked;
        String day = picked.day.toString();
        String month = DateFormat('MMMM').format(picked);
        String weekday = DateFormat('EEEE').format(picked);
        _dateController.text = '$day, $month $weekday';
      });
    }
  }

  DateTime convertTimeOfDayToDateTime(TimeOfDay time, DateTime date) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _saveTodo() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _pickedDate == null ||
        selectedStartTime == null ||
        selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('${AppLocalizations.of(context)?.requiredInput}'),
        ),
      );
      return;
    }

    final startDateTime = convertTimeOfDayToDateTime(
      selectedStartTime!,
      _pickedDate!,
    );
    final endDateTime = convertTimeOfDayToDateTime(
      selectedEndTime!,
      _pickedDate!,
    );

    final todo = Todo(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrls: null,
      uploadToCloud: false,
      startTime: startDateTime,
      endTime: endDateTime,
    );

    final box = Hive.box<Todo>('todos');
    await box.put(todo.id, todo);

    if (mounted) context.pop();
  }
  final rtdb = locator<FirebaseRealTimeDataBase>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)?.crateNewTask}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context)?.taskName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                suffixIcon: BlocBuilder<MicCubit, bool>(
                  builder: (context, isListening) {
                    return IconButton(
                      icon: Icon(isListening ? Icons.stop : Icons.mic),
                      onPressed: () {
                        if (isListening) {
                          voiceService.stopListening();
                          context.read<MicCubit>().stop();
                        } else {
                          _startListeningTitle();
                          context.read<MicCubit>().toggle();
                        }
                      },
                    );
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              '${AppLocalizations.of(context)?.description}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_isListeningDescription ? Icons.stop : Icons.mic),
                  onPressed: _isListeningDescription
                      ? voiceService.stopListening
                      : _startListeningDescription,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              '${AppLocalizations.of(context)?.dateTime}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.deepPurple,
                  ),
                  onPressed: _pickDate,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedStartTime ?? TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedStartTime = picked;
                        });
                      }
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedStartTime != null
                            ? selectedStartTime!.format(context)
                            : '${AppLocalizations.of(context)?.startTime}',
                        style: TextStyle(
                          color: selectedStartTime != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectedEndTime ?? TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedEndTime = picked;
                        });
                      }
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedEndTime != null
                            ? selectedEndTime!.format(context)
                            : '${AppLocalizations.of(context)?.endTime}',
                        style: TextStyle(
                          color: selectedEndTime != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Text(
                "Upload Cloud",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              title: BlocBuilder<CloudSwitchButtonCubit, bool>(
                builder: (context, upload) {
                  return Switch(
                    value: upload,
                    onChanged: (v) async {
                      if (v) {
                        context.read<CloudSwitchButtonCubit>().upload();
                      } else {
                        context.read<CloudSwitchButtonCubit>().stop();
                      }

                      if (_titleController.text.trim().isEmpty ||
                          _descriptionController.text.trim().isEmpty ||
                          _pickedDate == null ||
                          selectedStartTime == null ||
                          selectedEndTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('${AppLocalizations.of(context)?.requiredInput}'),
                          ),
                        );
                        return;
                      }

                      final startDateTime = convertTimeOfDayToDateTime(
                        selectedStartTime!,
                        _pickedDate!,
                      );
                      final endDateTime = convertTimeOfDayToDateTime(
                        selectedEndTime!,
                        _pickedDate!,
                      );

                      final todo = Todo(
                        id: const Uuid().v4(),
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        imageUrls: null,
                        uploadToCloud: v, // 🔥 switch qiymati
                        startTime: startDateTime,
                        endTime: endDateTime,
                      );

                      final box = Hive.box<Todo>('todos');

                      if (v) {
                        await rtdb.uploadTodo(todo);
                        print("Firebas yuklandi ");
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 190),
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
    );
  }
}
