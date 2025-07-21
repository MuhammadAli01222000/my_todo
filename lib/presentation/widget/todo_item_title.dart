import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/core/services/speech_to_text.dart';

import '../../core/constants/app_icons.dart';
import '../bloc/cubit/completed_button_cubit.dart';

class TodoItemTile extends StatelessWidget {
  final String title;
  final String time;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItemTile({
    super.key,
    required this.title,
    required this.time,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompletedButtonCubit(),
      child: Builder(
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              leading: BlocBuilder<CompletedButtonCubit, bool>(
                builder: (context, isChecked) {
                  return Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      context.read<CompletedButtonCubit>().toggle(val);
                    },
                  );
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(onTap: onEdit, child: AppIcons.edit),
                  const SizedBox(width: 10),
                  GestureDetector(onTap: onDelete, child: AppIcons.delete),
                  IconButton(
                    icon: Icon(AppIcons.sound, color: Colors.grey),
                    onPressed: () async {
                      final speech = SpeechToTextService();
                      final initialized = await speech.initSpeech();
                      debugPrint(initialized.toString());
                      if (!initialized) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mikrofon ishga tushmadi'),
                          ),
                        );
                        return;
                      }

                      final locale = Localizations.localeOf(
                        context,
                      ).languageCode;

                      await speech.startListening(
                        localeId: locale,
                        onResult: (text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Natija: $text')),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
