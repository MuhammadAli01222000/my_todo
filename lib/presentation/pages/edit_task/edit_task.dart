import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/domain/interfaces/hive_service.dart';
import 'package:my_todo/injcetion/locator.dart';
import '../../../core/services/hive_service_impl.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../../l10n/app_localizations.dart';

class EditTask extends StatefulWidget {
  final Todo todo;
  const EditTask({super.key, required this.todo});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final TextEditingController _dateController = TextEditingController();
  final todoService=locator<ITodoService>();
  String selectedCategory = 'Education';
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(text: widget.todo.description);

    // Date
    if (widget.todo.startTime != null) {
      _pickedDate = widget.todo.startTime;
      String day = _pickedDate!.day.toString();
      String month = DateFormat('MMMM').format(_pickedDate!);
      String weekday = DateFormat('EEEE').format(_pickedDate!);
      _dateController.text = '$day, $month $weekday';
    }

    // Start Time
    if (widget.todo.startTime != null) {
      selectedStartTime = TimeOfDay.fromDateTime(widget.todo.startTime!);
    }

    // End Time
    if (widget.todo.endTime != null) {
      selectedEndTime = TimeOfDay.fromDateTime(widget.todo.endTime!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

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

  void _saveChanges() async{
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _pickedDate == null ||
        selectedStartTime == null ||
        selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Barcha maydonlarni to‘ldiring (Title, Description, Date, Start va End Time)'),
        ),
      );
      return;
    }

    final startDateTime = convertTimeOfDayToDateTime(selectedStartTime!, _pickedDate!);
    final endDateTime = convertTimeOfDayToDateTime(selectedEndTime!, _pickedDate!);

    Todo todo = Todo(
      id: widget.todo.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrls: widget.todo.imageUrls,
      uploadToCloud: widget.todo.uploadToCloud,
      startTime: startDateTime,
      endTime: endDateTime,
    );
    await todoService.writeTodo(todo);


    Navigator.pop(context, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // yoz todo
      appBar: AppBar(title:  Text('${AppLocalizations.of(context)?.editTodo}'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('${AppLocalizations.of(context)?.taskName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),

             Text('${AppLocalizations.of(context)?.category}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TaskButton(isActivated: true, category: "${AppLocalizations.of(context)?.education}", onTap: () {}),
                TaskButton(isActivated: false, category: "${AppLocalizations.of(context)?.work}", onTap: () {}),
                TaskButton(isActivated: false, category: "${AppLocalizations.of(context)?.groceries}", onTap: () {}),
              ],
            ),
            const SizedBox(height: 16),

             Text('${AppLocalizations.of(context)?.dateTime}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month, color: Colors.deepPurple),
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
                            : "${AppLocalizations.of(context)?.startTime}",
                        style: TextStyle(
                          color: selectedStartTime != null ? Colors.black : Colors.grey,
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
                          color: selectedEndTime != null ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

             Text('${AppLocalizations.of(context)?.priority}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskButton(isActivated: true, category: "${AppLocalizations.of(context)?.low}", onTap: () {}),
                TaskButton(isActivated: false, category: "${AppLocalizations.of(context)?.medium}", onTap: () {}),
                TaskButton(isActivated: false, category: "${AppLocalizations.of(context)?.high}", onTap: () {}),
              ],
            ),
            const SizedBox(height: 16),

             Text('${AppLocalizations.of(context)?.description}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),

            Center(
              child: SizedBox(
                width: 293.15,
                height: 59.46,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Color(0xFF9747FF)),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  onPressed: _saveChanges,
                  child:  Center(
                    child: Text(
                      '${AppLocalizations.of(context)?.save}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final bool isActivated;
  final String category;
  final VoidCallback onTap;

  const TaskButton({
    super.key,
    required this.isActivated,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
          color: isActivated ? Colors.deepPurple : Colors.deepPurpleAccent,
          width: 0.5,
        ),
        backgroundColor: isActivated
            ? const Color(0xFF9747FF)
            : const Color(0xFFCCAAF8),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: isActivated ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
