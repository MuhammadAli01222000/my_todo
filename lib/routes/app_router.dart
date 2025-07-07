import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_todo/presentation/pages/auth/sign_in.dart';
import 'package:my_todo/presentation/pages/cloud/cloud.dart';
import 'package:my_todo/presentation/pages/edit_task/edit_task.dart';
import 'package:my_todo/presentation/pages/home/home_page.dart';
import 'package:my_todo/core/services/auth_service_impl.dart';
import 'package:my_todo/presentation/pages/settings/settings_page.dart';
import 'package:my_todo/presentation/pages/splash/splash_page.dart';
import 'package:my_todo/presentation/pages/voice_recorder/voice_todo.dart';
import '../domain/entities/todo_entity.dart';
import '../presentation/bloc/cubit/cloud_switch_button.dart';
import '../presentation/pages/create_task/create_task.dart';
import 'path_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutePath.splash,
  redirect: (context, state) async {
    final bool isLoggedIn = await AuthService.checkLoginStatus();
    final String location = state.fullPath ?? '';


    final bool isOnAuthPage = location == AppRoutePath.signUp || location == AppRoutePath.login;
    final bool isOnSplash = location == AppRoutePath.splash;

    if (!isLoggedIn && !isOnAuthPage && !isOnSplash) {
      return AppRoutePath.login;
    }

    if (isLoggedIn && isOnAuthPage) {
      return AppRoutePath.home;
    }

    if (isLoggedIn && isOnSplash) {
      return AppRoutePath.home;
    }

    return null;
  },
  routes: [
    /// add task
    GoRoute(
      path: AppRoutePath.addTask,
      name: AppRouteName.addTask,
      builder: (context, state) => BlocProvider(
        create: (_) => CloudSwitchButtonCubit(),
        child: const CreateTask(),
      ),
    ),
    /// sign Up
    GoRoute(
      path: AppRoutePath.signUp,
      name: AppRouteName.signUp,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutePath.voiceRecorder,
      name: AppRouteName.voiceRecorder,
      builder: (context, state) => const VoiceRecorder(),
    ),
    GoRoute(
      path: AppRoutePath.edit,
      name: AppRouteName.edit,
      builder: (context, state) {
        final Todo todo = state.extra as Todo;
        return EditTask(todo: todo);
      },
    ),
    GoRoute(
      path: AppRoutePath.login,
      name: AppRouteName.login,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutePath.splash,
      name: AppRouteName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutePath.home,
      name: AppRouteName.home,
      builder: (context, state) => const HomePage(),
    ),
    /// cloud
    GoRoute(
      path: AppRoutePath.cloud,
      name: AppRouteName.cloud,
      builder: (context, state) =>  Cloud(),
    ),

    /// setting
    GoRoute(path: AppRoutePath.settings,name: AppRouteName.settings,builder: (context,state)=>const  SettingsPage()),
  ],
);