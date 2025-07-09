import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/l10n/app_localizations.dart';
Future<void> deleteTodoDialog({
  required String id,
  required BuildContext context,
  required Future<void> Function() onTap,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("${AppLocalizations.of(context)?.todoDelete}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        icon: AppIcons.delete,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text("${AppLocalizations.of(context)?.goBack}",style: TextStyle(color: Colors.green),),
          ),
          TextButton(
            onPressed: () async {
              await onTap();
              if (context.mounted) context.pop();
            },
            child: Text("${AppLocalizations.of(context)?.yes}",style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
