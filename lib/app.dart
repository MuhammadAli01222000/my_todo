import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_todo/presentation/bloc/cubit/cloud_switch_button.dart';
import 'package:my_todo/presentation/bloc/cubit/completed_button_cubit.dart';
import 'package:my_todo/presentation/bloc/cubit/l10_cubit.dart';
import 'package:my_todo/presentation/bloc/cubit/microphone_cubit.dart';
import 'package:my_todo/presentation/pages/create_task/create_task.dart';

import '../l10n/app_localizations.dart';
import '../routes/app_router.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<L10nCubit>(
          create: (_) => L10nCubit(), // default: 'uz'
        ),

        BlocProvider<MicCubit>(create: (_) => MicCubit()),
        BlocProvider<CloudSwitchButtonCubit>(create: (_) => CloudSwitchButtonCubit()),
        BlocProvider<CompletedButtonCubit>(create: (_) => CompletedButtonCubit()),
        BlocProvider(
          create: (_) => CloudSwitchButtonCubit(),
          child: CreateTask(),
        )

      ],
      child: BlocBuilder<L10nCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            locale: locale,
            supportedLocales: const [Locale('en'), Locale('ru'), Locale('uz')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
